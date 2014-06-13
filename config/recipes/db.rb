namespace :db do
  task :setup, :version do |task, args|
    on roles :db do
      invoke 'db:postgres:setup'
    end
  end
  namespace :postgres do
    task :setup, :version do |task, args|
      on roles :db do
        invoke 'package:install', "postgresql-#{args and args[:verison] or 9.3} libpq-dev"
        execute :sudo, 'mkdir -p /var/lib/postgresql/'
        erb_file = ERB.new(File.new('config/database.yml').read).result
        config = YAML.load erb_file
        env = fetch(:stage).to_s
        puts config[env]
        database = config[env]['database']
        username = config[env]['username']
        password = config[env]['password']
        execute %Q{sudo -u postgres psql -c "create user #{username}#{" with password '#{password}'" if password};"}
        execute %Q{sudo -u postgres psql -c "create database #{database} owner #{username};"}
      end
    end
  end
end
