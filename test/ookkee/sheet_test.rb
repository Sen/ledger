require 'test_helper'

class Ookkee::SheetTest < ActiveSupport::TestCase
  test "truth" do
    assert_equal Ookkee::Sheet.new.class.name, 'Ookkee::Sheet'
  end

  test "create" do
    count = Ookkee::Sheet.count
    sheet = Ookkee::Sheet.new
    sheet.save

    assert_equal Ookkee::Sheet.count, count + 1
  end

end
