require "inflecto"

module Factories
  def self.gen(name, &blk)
    klass = Class.new(BaseFactory, &blk)
    Factories.const_set(factory_class_name_from_string(name).intern, klass)
    klass
  end

  def self.class_from_name(name)
    factory_name = factory_class_name_from_string(name)
    class_name = "Factories::#{factory_name}"
    Inflecto.constantize class_name
  end

  def self.factory_class_name_from_string(name)
    Inflecto.classify "#{name}_factory"
  end

  module_function

  def create(name, opts = {})
    Factories.class_from_name(name).create(opts)
  end

  def build(name, opts = {})
    Factories.class_from_name(name).build(opts)
  end
end

require "factories/version"
require "factories/base_factory"
