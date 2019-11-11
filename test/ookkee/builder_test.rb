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

  # account = Ookkee::Account.new
  # account.name = 'cash'
  # account.sheet_name = 'assets'
  # account.save!

  # Ookkee::Builder.build do
  #   title 'abcd'
  #   transaction_number 'dfdfdf'
  #   credit account do
  #     amount 100
  #     trackable order
  #     user current_user
  #   end
  #   debit account do
  #     amount 100
  #     trackable order
  #     user current_user
  #   end
  # end

  # test "credit method" do
  #   block = Proc.new {
  #     title 'abcd'
  #     transaction_number 'dfdfdf'
  #     credit @account do
  #       amount 100
  #       trackable @order
  #       user @user
  #     end
  #     debit @account do
  #       amount 100
  #       trackable @order
  #       user @user
  #     end
  #   }
  #   builder = Ookkee::Builder.new
  #   builder.instance_eval(&block)

  #   # puts builder.registry.inspect
  #   # puts builder.inspect
  # end

  test 'build' do
    account = Ookkee::Account.new
    account.name = 'cash'
    account.sheet_name = 'assets'
    account.save!

    sheet = Ookkee::Builder.build do |b|
      b.title 'abcd'
      b.transaction_number 'dfdfdf'
      b.credit account do |cr|
        cr.amount 100
        cr.trackable @order
        cr.user @user
      end
      b.debit account do |dr|
        dr.amount 200
        dr.trackable @order
        dr.user @user
      end
    end

    sheet.save!

    assert_equal sheet.title, 'abcd'
    assert_equal sheet.transaction_number, 'dfdfdf'

    credit = sheet.entries.where(entry_type: 'credit').first
    assert_equal credit.amount_cents, 10000
    assert_equal credit.trackable_id, @order.id
    assert_equal credit.trackable_type, 'Order'
    assert_equal credit.user_id, @user.id
    assert_equal credit.user_type, 'User'

    debit = sheet.entries.where(entry_type: 'debit').first
    assert_equal debit.amount_cents, 20000
    assert_equal debit.trackable_id, @order.id
    assert_equal debit.trackable_type, 'Order'
    assert_equal debit.user_id, @user.id
    assert_equal debit.user_type, 'User'
  end

end
