module Ookkee
  class Sheet < ActiveRecord::Base
    self.table_name = "ookkee_sheets"

    has_many :entries, class_name: 'Ookkee::Entry', foreign_key: :sheet_id
  end
end