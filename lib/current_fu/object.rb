module CurrentFu
  class Object
    
    cattr_accessor  :instance
    
    def initialize(current_owner)
      @current_owner = current_owner
    end
    
    def instance
      @current_owner
    end
    
    def respond_to?(method)
      current_owner_respond_to?(method) || super
    end

    
    protected
    
    def current_method(method)
      :"current_#{method}"
    end
    
    def current_owner_respond_to?(method)
      @current_owner.respond_to? current_method(method)
    end
    
    def method_missing(method, *args)
      if current_owner_respond_to?(method)
        if block_given?
          @current_owner.send(current_method(method),*args) { |*block_args| yield(*block_args) }
        else
          @current_owner.send(current_method(method),*args)
        end
      else
        block_given? ? super { |*block_args| yield(*block_args) } : super
      end
    end
    
  end
end
