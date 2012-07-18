require 'rubygems'
require 'bundler'
require "bundler/setup"
Bundler.require
require 'current_fu'
require 'active_record/base'
require 'action_controller/base'
require 'minitest/autorun'
require 'logger'


ActiveRecord::Base.logger = Logger.new(File.join(File.dirname(__FILE__),'debug.log'))
ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database => ':memory:'


module CurrentFu
  class TestCase < MiniTest::Spec
    
    before { setup_environment }
    after  { cleanup }
    
    protected
    
    def cleanup
      CurrentFu::Object.instance = nil
    end
    
    def setup_environment
      setup_database
      setup_data
    end
    
    def setup_database
      ActiveRecord::Base.class_eval do
        silence do
          connection.create_table :employees, :force => true do |t|
            t.column :name,  :string
            t.column :email, :string
            t.column :age,   :integer
          end
        end
      end
    end
    
    def setup_data
      Employee.create :name => 'Ken Collins', :email => 'ken@metaskills.net', :age => 39
    end
    
  end
end

class Employee < ActiveRecord::Base
  include CurrentFu::Getter
end

module TestAuthSystem
  include CurrentFu::Getter
  def current_user
    @current_user ||= Employee.first
  end
  def current_user=(user)
    @current_user = user
  end
end

class TestApplicationController < ActionController::Base
  include TestAuthSystem
end

