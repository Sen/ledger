module Ookkee
  class Builder
    attr_accessor :registry

    def initialize
      @registry = []
      @attributes = {}
    end

    def self.build
      instance = self.new
      yield instance

      instance.build_activerecord_objects
    end

    def title(value)
      @attributes[:title] = value
    end

    def transaction_number(value)
      @attributes[:transaction_number] = value
    end

    def credit(account, &block)
      builder_proxy = BuilderProxy.new({builder: self})
      builder_proxy.credit(account, &block)
    end

    def debit(account, &block)
      builder_proxy = BuilderProxy.new({builder: self})
      builder_proxy.debit(account, &block)
    end

    def build_activerecord_objects
      sheet = Sheet.new(
        title: @attributes[:title],
        transaction_number: @attributes[:transaction_number]
      )
      registry.each do |element|
        entry_repo.build_from_factory(sheet, element)
      end

      sheet
    end

    private

    def entry_repo
      @entry_repo ||= EntryRepo.new
    end
  end
end
