module Ookkee
  class AccountError < StandardError; end

  class Transaction
    attr_accessor :account_repo

    def self.create(&block)
      # builder = Builder.new
      # builder.instance_eval(&block)
      # check account
      # create sheet
      # add credit/debit
      # save with db transaction
    end

    private

    def account_repo
      @account_repo ||= AccountRepo.new
    end
  end
end
