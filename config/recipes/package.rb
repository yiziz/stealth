namespace :package do
  task :add, :repo do |task, args|
    on roles :all do
      invoke 'package:apt:add', args[:repo]
    end
  end
  task :install, :packages do |task, args|
    on roles :all do
      invoke 'package:apt:install', args[:packages]
    end
  end
  task :update do |task, args|
    on roles :all do
      invoke 'package:apt:update'
    end
  end
  namespace :apt do
    task :add, :repo do |task, args|
      on roles :all do
        execute :sudo, "add-apt-repository #{args[:repo]}"
      end
    end
    task :install, :packages do |task, args|
      on roles :all do
        execute :sudo, "apt-get install -y #{args[:packages]}"
      end
    end
    task :update do |task, args|
      on roles :all do
        execute :sudo, 'apt-get update'
      end
    end
  end
end
