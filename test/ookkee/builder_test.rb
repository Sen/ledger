require 'test_helper'

class Ookkee::BuilderTest < ActiveSupport::TestCase
  setup do
    @account = Ookkee::Account.new
    @account.name = 'cash'
    @account.sheet_name = 'assets'
    @account.save!

    @user = User.create!(name: 'tester')
    @order = Order.create!(title: 'test order')
  end

  test "klass" do
    assert_equal Ookkee::Builder.new.class.name, 'Ookkee::Builder'
  end

  test 'build' do
    balance_account = Ookkee::Account.new
    balance_account.name = 'balance'
    balance_account.sheet_name = 'assets'
    balance_account.save!

    bank_payable_account = Ookkee::Account.new
    bank_payable_account.name = 'bank payable'
    bank_payable_account.sheet_name = 'liabilities'
    bank_payable_account.save!

    sheet = Ookkee::Builder.build do |b|
      b.title 'abcd'
      b.transaction_number 'dfdfdf'
      b.user @user
      b.credit bank_payable_account do |cr|
        cr.amount 200
        cr.trackable @order
      end
      b.debit balance_account do |dr|
        dr.amount 200
        dr.trackable @order
      end
    end

    sheet.save!

    assert_equal sheet.title, 'abcd'
    assert_equal sheet.transaction_number, 'dfdfdf'
    assert_equal sheet.user_id, @user.id
    assert_equal sheet.user_type, 'User'

    credit = sheet.entries.where(entry_type: 'credit').first
    assert_equal credit.amount, 200
    assert_equal credit.trackable_id, @order.id
    assert_equal credit.trackable_type, 'Order'
    assert_equal credit.account.name, 'bank payable'
    assert_equal credit.account.sheet_name, 'liabilities'

    debit = sheet.entries.where(entry_type: 'debit').first
    assert_equal debit.amount, 200
    assert_equal debit.trackable_id, @order.id
    assert_equal debit.trackable_type, 'Order'
    assert_equal debit.account.name, 'balance'
    assert_equal debit.account.sheet_name, 'assets'
  end

end
