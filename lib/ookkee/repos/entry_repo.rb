require 'bigdecimal'

module Ookkee
  class EntryRepo
    def build_from_factory(sheet, factory)
      entry              = sheet.entries.build
      entry.account      = factory.attributes[:account]
      entry.trackable    = factory.attributes[:trackable]
      entry.user         = factory.attributes[:user]
      entry.sheet_name   = factory.attributes[:sheet_name]
      entry.entry_type   = factory.attributes[:entry_type]
      entry.amount       = BigDecimal(factory.attributes[:amount] || 0)

      entry
    end
  end
end