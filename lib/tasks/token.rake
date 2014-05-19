require Rake.original_dir + '/config/initializers/secret_token.rb'
namespace :token do
  desc 'Create token'
  task :create do
    Rake::Task['token:mkdir'].invoke
    Rake::Task['token:chown'].invoke
  end
  desc 'Change token directory owner'
  task :chown do
    sh "sudo chown -R #{ENV['USER']} #{Token.token_dir}"
  end
  desc 'Create token directory'
  task :mkdir do
    sh "sudo mkdir -p #{Token.token_dir}"
  end
  desc 'Read secret token'
  task :read do
    puts Token.read_token
  end
  desc 'Update secret token'
  task :update do
    Token.secure_token(ENV['SECRET']) if ENV['SECRET']
  end
end
