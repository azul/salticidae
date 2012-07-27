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
end
