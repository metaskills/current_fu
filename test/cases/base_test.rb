
require 'helper'

class CurrentFu::BaseTest < CurrentFu::TestCase
  
  let(:base_klass)        { ActionController::Base }
  let(:base_instance)     { base_klass.new }
  let(:base_current)      { CurrentFu::Object.new(base_instance) }
  let(:app_instance)      { TestApplicationController.new }
  let(:app_current)       { CurrentFu::Object.new(app_instance) }
  let(:employee_klass)    { Employee }
  let(:employee_instance) { employee_klass.new }
  
  describe 'ControllerConcerns' do
    
    it 'mixins in #current method' do
      base_klass.protected_instance_methods.map(&:to_s).must_include 'current'
    end
  
    it 'wraps self via #current' do
      base_instance.send(:current).instance.must_equal base_instance
    end
    
    it 'sets up an around filter to #set_current' do
      callback = base_klass._process_action_callbacks.detect { |cb| cb.kind == :around && cb.filter == :set_current }
      assert callback
    end
    
    it 'sets the current instance with #set_current and always returns current instance to nil' do
      CurrentFu::Object.instance.must_be_nil
      base_instance.send :set_current do
        CurrentFu::Object.instance.must_be_instance_of CurrentFu::Object
        CurrentFu::Object.instance.instance.must_equal base_instance
      end
      CurrentFu::Object.instance.must_be_nil
    end
    
  end
  
  describe 'Getter' do
    
    it 'has both a class and instance for current instance object' do
      employee_klass.current.must_be_nil
      employee_instance.send(:current).must_be_nil
      CurrentFu::Object.instance = base_current
      employee_klass.current.must_be_instance_of CurrentFu::Object
      employee_klass.current.instance.must_equal base_instance
      employee_instance.current.instance.must_equal base_instance
    end
    
  end
  
  describe 'Object' do
    
    it 'delegates via #respond_to? and #method_missing to current_* methods of the instance' do
      user = Employee.first
      app_instance.current_user = user
      CurrentFu::Object.instance = app_current
      employee_instance.current.respond_to?(:user)
      employee_instance.current.user.must_equal user
    end
    
  end
  
end

