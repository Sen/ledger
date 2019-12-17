module Ookkee
  class Usecase
    def self.account_balance_with_user(account, user)
      repo = EntryRepo.new
      repo.calculate_account_balance(account, user)
    end

    def self.account_entries(account, user)
      repo = EntryRepo.new
      repo.account_entries_with_user(account, user)
    end

    def self.user_sheets(user)
      repo = EntryRepo.new
      repo.sheets_with_user(user)
    end
  end
end