namespace :ruby do
  task :setup, :version do |task, args|
    on roles :app do
      invoke 'ruby:rvm:setup'
      #invoke 'ruby:rvm:install', (args and args[:version] or '2.1.1')
      #invoke 'ruby:rvm:use', (args and args[:version] or '2.1.1')
      #invoke 'ruby:rails:setup'
    end
  end
  namespace :gem do
    task :install, :packages do |task, args|
      on roles :app do
        execute :gem, "install #{(args and args[:packages])}"
      end
    end
  end
  namespace :rails do
    task :setup, :version do |task, args|
      on roles :app do
        invoke 'ruby:gem:install', "rails -v #{(args and args[:version] or '4.1.1')}"
      end
    end
  end
  namespace :rvm do
    task :install do
      on roles :app, :version do |task, args|
        execute :rvm, "install #{(args and args[:version] or '2.1.1')}"
      end
    end
    task :setup, :version do |task, args|
      on roles :app do
        execute :curl, "-sSL https://get.rvm.io | bash -s -- --version #{args and args[:version] or 'latest'} --ruby=2.1.1"
      end
    end
    task :default, :version do |task, args|
      on roles :app do
        execute "#{fetch(:rvm_bin_path, '~/.rvm/bin')}/rvm use #{args[:version]} --default"
      end
    end
    task :use, :version do |task, args|
      on roles :app do
        execute "#{fetch(:rvm_bin_path, '~/.rvm/bin')}/rvm use #{args[:version]}"
      end
    end
  end
end
