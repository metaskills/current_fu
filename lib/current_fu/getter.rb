require 'active_support/concern'

module CurrentFu
  module Getter
    
    extend ActiveSupport::Concern
    
    module ClassMethods
      
      def current
        CurrentFu::Object.instance
      end
      
    end
    
    def current
      self.class.current
    end
    
  end
end

