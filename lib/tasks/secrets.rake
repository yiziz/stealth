require Rake.original_dir + '/config/initializers/secret_token.rb'
namespace :secrets do
  desc 'Create secret token'
  task :create do
    Rake::Task['secrets:mkdir'].invoke
    Rake::Task['secrets:chown'].invoke
    Rake::Task['secrets:chmod'].invoke
  end
  desc 'Change token directory owner'
  task :chown do
    sh "sudo chown -R #{ENV['USER']} #{SecretToken.token_dir}"
  end
  desc 'Update token directory permissions'
  task :chmod do
    sh "sudo chmod -R 700 #{SecretToken.token_dir}"
  end
  desc 'Create token directory'
  task :mkdir do
    sh "sudo mkdir -p #{SecretToken.token_dir}"
  end
  desc 'Read secret token'
  task :read do
    puts SecretToken.read_token
  end
  desc 'Update secret token'
  task :update do
    SecretToken.secure_token(ENV['SECRET']) if ENV['SECRET']
  end
end
