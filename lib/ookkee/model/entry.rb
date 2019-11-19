module Ookkee
  class Entry < ActiveRecord::Base
    self.table_name = "ookkee_entries"

    ENTRY_TYPES = %w[credit debit]
    SHEET_NAMES = %w[assets liabilities equity revenue expenses]

    belongs_to :sheet, class_name: 'Ookkee::Sheet', foreign_key: :sheet_id
    belongs_to :account, class_name: 'Ookkee::Account', foreign_key: :account_id
    belongs_to :trackable, polymorphic: true

    validates :entry_type, presence: true, \
      inclusion: {
        in: ENTRY_TYPES,
        message: "%{value} is not a valid entry type"
      }
    validates :sheet_name, presence: true, \
      inclusion: {
        in: SHEET_NAMES,
        message: "%{value} is not a valid account name"
      }
  end
end
