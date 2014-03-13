module Factories
  module_function

  def create(name, opts = {})
    class_from_name(name).create(opts)
  end

  def build(name, opts = {})
    class_from_name(name).build(opts)
  end

  def class_from_name(name)
    class_name = "#{name}_factory"
    class_name = class_name.classify
    class_name = "Factories::#{class_name}"
    class_name.constantize
  end
end

require "factories/version"
require "factories/base_factory"
