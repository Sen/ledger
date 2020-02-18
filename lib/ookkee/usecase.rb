module Ookkee
  class Usecase
    class << self
      def account_balance_with_user(account, user)
        repo.calculate_account_balance(account, user)
      end

      def account_entries(account, user)
        repo.account_entries_with_user(account, user)
      end

      def user_sheets(user)
        repo.sheets_with_user(user)
      end

      private

      def repo
        @repo ||= EntryRepo.new
      end
    end
  end
end