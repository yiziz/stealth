# config valid only for Capistrano 3.1
lock '3.2.1'

load 'config/recipes/base.rb'
load 'config/recipes/tools.rb'
load 'config/recipes/package.rb'
load 'config/recipes/ruby.rb'
load 'config/recipes/nginx.rb'
load 'config/recipes/passenger.rb'
load 'config/recipes/db.rb'
load 'config/recipes/secrets.rb'

set :application, 'stealth'
set :repo_url, 'git@github.com:yz0075/stealth.git'

set :deploy_via, :remote_cache
#set :use_sudo, false

set :ssh_options, {
  :forward_agent => true
}

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :default_env, {
  :rvm_bin_path => '~/.rvm/bin',
  #:bundle_bin_path => '/home/ln_prod/.rvm/gems/ruby-2.1.2@global/bin'
}
#set :rvm_bin_path, '~/.rvm/bin'
#set :rvm_type, :user

#set :bundle_cmd, '~/.rvm/gems/ruby-2.1.2@global/bin/bundle'
#set :bundle_dir, '~/.rvm/gems/ruby-2.1.2'

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do

  desc 'Prepare deployment boxes'
  task :prepare do
    invoke 'passenger:setup'
  end

  desc 'Setup deployment boxes'
  task :setup do
    invoke 'tools:setup'
    invoke 'ruby:setup'
    invoke 'passenger:setup'
    
    invoke 'db:setup'
    on roles :db do
    end
    on roles :app do
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  task :foo do
    on roles(:app) do
      invoke "deploy:bar"
    end
  end

  task :bar do
    on roles(:all) do
      execute "ls"
    end
  end
  after :finishing, 'bundler:install'
end

#after 'deploy', 'bundler:install'

# deploy components
#
# install
#   rvm
#   nginx
#   passenger
#   postgres
#   node
#   python-dev
#   git
#   
# deployment
#   nginx
#   passenger
#   rails
#   ember
