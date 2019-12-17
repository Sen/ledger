require 'bigdecimal'

module Ookkee
  class EntryRepo
    def build_from_factory(sheet, factory)
      entry              = sheet.entries.build
      entry.account      = factory.attributes[:account]
      entry.trackable    = factory.attributes[:trackable]
      entry.sheet_name   = factory.attributes[:sheet_name]
      entry.entry_type   = factory.attributes[:entry_type]
      entry.amount       = BigDecimal(factory.attributes[:amount] || 0)

      entry
    end

    def sheets_with_user(user)
      Ookkee::Sheet.where(user_id: user.id, user_type: user.class.name).order('created_at DESC')
    end

    def account_entries_with_user(account, user)
      Ookkee::Entry.joins(:account, :sheet)
        .where(sheet_name: account.sheet_name)
        .where('ookkee_accounts.name = ?', account.name)
        .where('ookkee_sheets.user_id = ? and ookkee_sheets.user_type = ?', user.id, user.class.name)
        .order('ookkee_entries.created_at DESC')
    end

    def calculate_account_balance(account, user)
      entries = account_entries_with_user(account, user)
      entries.where('entry_type = ?', 'debit').sum(:amount) - entries.where('entry_type = ?', 'credit').sum(:amount)
    end
  end
end