module SendingMail
  extend ActiveSupport::Concern

  def queue_mail(mailer, action, target=nil, options=nil)
    Email.create mailer: mailer, action: action, target: target, options: options
  end

  def deliver_mail(mailer, action, target=nil, options=nil)
    Email.to_mail(mailer, action, target, options).deliver
  end
end
