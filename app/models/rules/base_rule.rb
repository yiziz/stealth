module Rules
  class BaseRule
    def self.resource_rules
      {
        if_true: lambda {|r| true},
        if_false: lambda {|r| false}
      }
    end
    def self.process_resource_rules(rules)
      a = rules.map do |k|
        self.resource_rules[k] or self.resource_rules[:if_false]
      end if rules
      return a
    end
    def self.find(key, controller)
      action_rules, resource_rules = "Rules::#{controller.camelize}Rule".constantize.rules[key.to_sym]
      [controller.to_sym, action_rules, process_resource_rules(resource_rules)]
    end
  end
end
