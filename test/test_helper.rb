ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'mocha'

class ActiveSupport::TestCase

  def attributes_for(klass)
    case klass
    when :user
      { :login => "me",
        :password_verifier => "1234",
        :password_salt => "4321" }
    end
  end

  def assert_json_response(object)
    object.stringify_keys! if object.respond_to? :stringify_keys!
    assert_equal object, JSON.parse(@response.body)
  end
end
