
require 'securerandom'

secret_config = YAML.load 'config/secrets.yml'
secret_key_length = secret_config['token_length']
secret_key=SecureRandom.hex secret_key_length/2

namespace :secrets do

  task :setup do
    on roles :app do
      within current_path do
        execute :rake, "secrets:create"
      end
    end
  end

  task :read do
    on roles :app do
      within current_path do
        output = capture :rake, "secrets:read"
        output.each_line do |line|
          secret_key = line and break if line and line.length == secret_key_length
        end
      end
    end
  end

  task :tokenize do
    on roles :app do
      within current_path do
        execute :rake, "secrets:update SECRET=#{secret_key}"
      end
    end
  end
end

after "deploy", "secrets:setup"
after "secrets:setup", "secrets:read"
after "secrets:read", "secrets:tokenize"
