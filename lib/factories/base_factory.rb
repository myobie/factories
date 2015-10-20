require "inflecto"

module Factories
  class BaseFactory
    def self.create(opts = {})
      new(opts).create
    end

    def self.build(opts = {})
      new(opts).build
    end

    def self.model_class(klass = nil)
      if klass
        @model_class = klass
      else
        @model_class ||= Inflecto.constantize(Inflecto.demodulize(name.gsub(/Factory$/, '')))
      end
    end

    def model_class
      self.class.model_class
    end

    def defaults
      raise "not implimented"
    end

    def self.defaults(&blk)
      define_method(:defaults, &blk)
    end

    def initialize(opts = {})
      @opts = opts
      @attributes = defaults.merge(opts)
    end

    def create
      build.tap { |instance| instance.save || raise_create_failure }
    end

    def build
      model_class.new.tap do |instance|
        attrs = expand_procs @attributes, instance
        instance.assign_attributes attrs
      end
    end

    private

    def expand_procs(hash, instance)
      hash.each_with_object({}) do |(k, v), h|
        v = if v.is_a?(Proc)
          if v.arity == 1
            v.call(instance)
          else
            v.call
          end
        else
          v
        end

        h[k] = v
      end
    end
  
    def raise_create_failure
      error_message = if instance.respond_to?(:errors)
        if instance.errors.respond_to?(:full_messages)
          instance.errors.full_messages
        else
          instance.errors.to_s
        end
      end

      raise "Factory model did not save: (#{error_message})"
    end
  end
end
