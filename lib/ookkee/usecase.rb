module Ookkee
  class Usecase
    def self.account_balance_with_user(account, user)
      repo = EntryRepo.new
      repo.calculate_account_balance_with_user(account, user)
    end

    def self.account_entries(account, user)
      repo = EntryRepo.new
      repo.account_entries_with_user(account, user)
    end
  end
end