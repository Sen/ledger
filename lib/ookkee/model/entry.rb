module Ookkee
  class Entry < ActiveRecord::Base
    self.table_name = "ookkee_entries"

    belongs_to :sheet, class_name: 'Ookkee::Sheet', foreign_key: :sheet_id
    belongs_to :account, class_name: 'Ookkee::Account', foreign_key: :account_id
    belongs_to :trackable, polymorphic: true
    belongs_to :user, polymorphic: true

    validates :entry_type, presence: true, \
      inclusion: {
        in: %w[credit debit],
        message: "%{value} is not a valid entry type"
      }
    validates :sheet_name, presence: true, \
      inclusion: {
        in: %w[assets liability equity revenue expense],
        message: "%{value} is not a valid account name"
      }
  end
end
