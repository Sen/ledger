module Ookkee
  class Account < ActiveRecord::Base
    self.table_name = "ookkee_accounts"

    validates :name, presence: true
    validates :sheet_name, presence: true, \
      inclusion: {
        in: Entry::SHEET_NAMES,
        message: "%{value} is not a valid account name"
      }
  end
end
