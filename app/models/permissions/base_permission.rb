module Permissions
  class BasePermission

    def initialize(user = nil, params = nil)
      @params = params
      @allowed_actions = {}
      @controller = @params[:controller]
      @action = @params[:action]
      allow_perms(user)
    end

    def allow_perms(user = nil)
      Object.const_get(self.class.name).rules.each do |name|
        key, controller = retrieve_key(name)
        allow_block(*Rules::BaseRule.find(key, controller)) if controller == @controller
      end
    end

    def retrieve_key(name)
      key, _, controller = name.to_s.rpartition('__')
      controller.gsub!('_', '/')
      return key, controller
    end

    def allow?(resource = nil)
      controller, action = @controller, @action
      allowed = @allow_all || @allowed_actions[[controller.to_s, action.to_s]]
      allowed && (allowed == true || allowed.call(resource))
    end

    def allow_all
      @allow_all = true
    end

    def allow_block(controllers, actions, block = nil)
      if block.nil?
        return allow(controllers, actions)
      end
      if block.class.name == 'Array'
        r_perms = block
        block = lambda do |resource|
          auth = true
          r_perms.each{|a|
            auth = auth && a.call(resource)
            break unless auth
          }
          return auth
        end
      end
      return allow(controllers, actions, &block)
    end

    def allow(controllers, actions, &block)
      @allowed_actions ||= {}
      Array(controllers).each do |controller|
        Array(actions).each do |action|
          @allowed_actions[[controller.to_s, action.to_s]] = block || true
        end
      end
    end

    def allow_param(resources, attributes)
      @allowed_params ||= {}
      Array(resources).each do |resource|
        @allowed_params[resource] ||= []
        @allowed_params[resource] += Array(attributes)
      end
    end

    def allow_param?(resource, attribute)
      if @allow_all
        true
      elsif @allowed_params && @allowed_params[resource]
        @allowed_params[resource].include? attribute
      end
    end

    def permit_params!(params)
      if @allow_all
        params.permit!
      elsif @allowed_params
        @allowed_params.each do |resource, attributes|
          if params[resource].respond_to? :permit
            params[resource] = params[resource].permit(*attributes)
          end
        end
      end
    end
  end
end
