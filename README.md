# Factories

## Installation

Add this line to your application's Gemfile:

    gem 'factories'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install factories

## Usage

`Factories` responds to `#build` and `#create` and does exactly what you
would expect:

```ruby
class User < ActiveRecord::Base
  validates :name, presence: true
end

Factories.gen :user do
  def defaults
    {
      name: "Nathan"
    }
  end
end

user = Factories.build(:user)
user.persisted? # => false

user2 = Factories.create(:user)
user2.persisted? # => true

user3 = Factories.build(:user, name: "Jason")
user3.valid? # => true

user4 = Factories.build(:user, name: nil)
user4.valid? # => false
```

If you don't want to use the fancy `#gen` method, the equivilent is:

```ruby
module Factories
  class UserFactory < BaseFactory
    def defaults
      {
        name: "Nathan"
      }
    end
  end
end
```

For the best result, `include Factories` into your test/spec scope.

An example `spec_helper.rb` could be:

```ruby
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

Dir[Rails.root.join("spec/{support,factories}/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  include Factories

  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
end

describe User do
  context "with an invalid model" do
    let(:user) { create(:user, name: nil) }

    it "expects a name sucka" do
      expect(user).to_not be_valid
    end
  end
end
```
