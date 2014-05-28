class ApplicationPolicy
  attr_reader :user, :resource, :target

  def initialize(user, resource)
    @user = user
    @resource = resource
    @target = nil
    setup_target
    include_rules
  end

  def scope
    #Pundit.policy_scope!(user, record.class)
  end

  def policy_name
    self.class.name.chomp('Policy').downcase
  end

private

  def rule_name
    "#{policy_name.classify}Rule"
  end

  def include_rules
    return self.class.send(:include, "Rules::#{policy_name.classify}Rule".constantize) if Defined.has_rule? rule_name.to_sym
    self.class.send(:include, Rules::ApplicationRule)
  end
  
  def setup_target
    return unless @resource
    @target = @resource[policy_name.to_sym]
  end

end
