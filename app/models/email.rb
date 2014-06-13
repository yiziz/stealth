class Email < ActiveRecord::Base
  include ModelSerializer
  
  attr_accessor :target, :options
  
  def target=(model_obj)
    self[:target] = model_obj.to_ms if model_obj.kind_of? ActiveRecord::Base
  end
  def target
    return unless self[:target].is_ms?
    self[:target].to_mi
  end
  # not deep
  def options=(hash_obj)
    self[:options] = hash_obj.each do |k,v|
      hash_obj[k] = v.to_ms if v.kind_of? ActiveRecord::Base
    end.to_s if hash_obj.is_a? Hash
  end
  def options
    hash_obj = eval self[:options] if self[:options].is_a? String
    ActiveRecord::Base.transaction do
      hash_obj.each do |k,v|
        hash_obj[k] = v.to_mi if v.is_ms?
      end 
    end if hash_obj.is_a? Hash
  end

  def self.to_mail(mailer, action, *params)
    mailer = "#{mailer.capitalize}Mailer".constantize
    arity = mailer.instance_method(action).arity
    params = arity <= 0 ? [] : params[0..arity-1]
    mailer.send action, *params
  end

  def to_mail
    Email.to_mail mailer, action, target, options
  end

  def deliver!
    result = to_mail.deliver
    self.sent_on = result.date
    self.sent = true
    save
  end
end
