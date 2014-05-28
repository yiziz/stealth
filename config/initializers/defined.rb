class Defined
  def self.load
    self.load_rules
  end

  def self.load_rules
    rules_path = 'app/models/rules/'
    @rules ||= Set.new Dir.entries(rules_path).map do |file|
      file[0..-4].classify.to_sym if file[-3..-1] == '.rb'
    end
    @rules.delete nil
  end

  def self.has_rule?(rule)
    @rules.include? rule
  end
end

Defined.load
