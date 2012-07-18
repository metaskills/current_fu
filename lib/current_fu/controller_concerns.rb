require 'active_support/concern'

module CurrentFu
  module ControllerConcerns
    
    extend ActiveSupport::Concern
    
    included do
      around_filter :set_current
    end
    
    protected
    
    def current
      @current ||= CurrentFu::Object.new(self)
    end

    def set_current
      CurrentFu::Object.instance = current
      yield
    ensure
      CurrentFu::Object.instance = nil
    end
    
  end
end

ActiveSupport.on_load(:action_controller) { include CurrentFu::ControllerConcerns }
