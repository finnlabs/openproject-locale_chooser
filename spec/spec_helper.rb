RAILS_ENV = "test" unless defined? RAILS_ENV

# prevent case where we are using rubygems and test-unit 2.x is installed
begin
  require 'rubygems'
  gem "test-unit", "~> 1.2.3"
rescue LoadError
end

begin
  #require "config/environment" unless defined? RAILS_ROOT
  require 'spec/spec_helper'
rescue LoadError => error
  puts <<-EOS

    You need to install rspec in your ChiliProject project.
    Please execute the following code:

      gem install rspec-rails
      script/generate rspec

  EOS
  raise error
end

require File.dirname(__FILE__) + "/plugin_spec_helper"
include Terms::PluginSpecHelper

require 'redmine_factory_girl'

def login_user(user)
  @controller.send(:logged_user=, user)
  @controller.stub!(:find_current_user).and_return(user)
end
