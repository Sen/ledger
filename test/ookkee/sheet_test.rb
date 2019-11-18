require 'test_helper'

class Ookkee::SheetTest < ActiveSupport::TestCase
  test "truth" do
    assert_equal Ookkee::Sheet.new.class.name, 'Ookkee::Sheet'
  end
end
