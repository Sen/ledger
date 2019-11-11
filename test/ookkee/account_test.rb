require 'test_helper'

class Ookkee::AccountTest < ActiveSupport::TestCase
  test "truth" do
    assert_equal Ookkee::Account.new.class.name, 'Ookkee::Account'
  end

  test "create" do
    count = Ookkee::Account.count
    sheet = Ookkee::Account.new
    sheet.name = 'cash'
    sheet.sheet_name = 'assets'
    sheet.save!

    assert_equal Ookkee::Account.count, count + 1
  end

end
