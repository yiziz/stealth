namespace :email do
  namespace :deliver do
    task :all => :environment do
      # ActiveRecord::Base.transcation do
      Email.where(sent: false).each do |email|
        email.deliver!
      end
    end
  end
end
