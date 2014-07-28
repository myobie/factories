require "inflecto"

module Factories
  class BaseFactory
    def self.create(opts = {})
      new(opts).create
    end

    def self.build(opts = {})
      new(opts).build
    end

    def self.model_class
      Inflecto.constantize(Inflecto.demodulize(name.gsub(/Factory$/, '')))
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
      build.tap { |instance| instance.save || raise("Factory model did not save:" + instance.errors.full_messages.join(", ")) }
    end

    def build
      model_class.new(@attributes)
    end
  end
end
