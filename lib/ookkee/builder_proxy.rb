module Ookkee
  class BuilderProxy
    def initialize(options)
      @builder = options[:builder]
    end

    def credit(account)
      factory = Factory.new
      yield factory
      factory.entry_type 'credit'
      factory.account account
      factory.sheet_name account.sheet_name

      @builder.registry << factory
    end

    def debit(account)
      factory = Factory.new
      yield factory
      factory.entry_type 'debit'
      factory.account account
      factory.sheet_name account.sheet_name

      @builder.registry << factory
    end
  end
end