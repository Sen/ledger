module Ookkee
  class Sheet < ActiveRecord::Base
    self.table_name = "ookkee_sheets"

    has_many :entries, class_name: 'Ookkee::Entry', foreign_key: :sheet_id

    validates :title, presence: true
    validates :transaction_number, uniqueness: { allow_blank: true, case_sensitive: false }
    validate :credit_and_debit_must_be_exists
    validate :ledger_equalities

    Entry::ENTRY_TYPES.each do |type|
      define_method "#{type}_filter" do |*args|
        args[0].select { |entry| entry.entry_type == type }
      end
    end

    Entry::SHEET_NAMES.each do |name|
      define_method "#{name}_filter" do |*args|
        args[0].select { |entry| entry.sheet_name == name }
      end
    end

    private

    def credit_and_debit_must_be_exists
      if credit_filter(entries).count == 0 || debit_filter(entries).count == 0
        errors.add(:base, "credit and debut must be exists")
      end
    end

    def ledger_equalities
      assets      = ledger_left(assets_filter(entries))
      expenses    = ledger_left(expenses_filter(entries))
      liabilities = ledger_right(liabilities_filter(entries))
      equity      = ledger_right(equity_filter(entries))
      revenue     = ledger_right(revenue_filter(entries))

      if assets + expenses != liabilities + equity + revenue
        errors.add(:base, "credits amount must equal to debits amount")
      end
    end

    def ledger_left(collection)
      debits  = debit_filter(collection).inject(0) { |sum, entry| sum + entry.amount }
      credits = credit_filter(collection).inject(0) { |sum, entry| sum + entry.amount }
      debits - credits
    end

    def ledger_right(collection)
      -1 * ledger_left(collection)
    end
  end
end