require "active_support/core_ext/string/inflections"

module Factories
  class BaseFactory
    def self.create(opts = {})
      new(opts).create
    end

    def self.build(opts = {})
      new(opts).build
    end

    def self.model_class
      name.gsub(/Factory$/, '').demodulize.constantize
    end

    def model_class
      self.class.model_class
    end

    def defaults
      raise "not implimented"
    end

    def initialize(opts = {})
      @opts = opts
      @attributes = defaults.merge(opts)
    end

    def create
      build.tap { |instance| instance.save! }
    end

    def build
      model_class.new(@attributes)
    end
  end
end
