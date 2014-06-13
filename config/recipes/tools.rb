namespace :tools do
  task :setup do
    on roles :app do
      invoke 'tools:development:setup'
      invoke 'tools:git:setup'
      invoke 'tools:node:prepare'
      invoke 'tools:node:setup'
    end
  end
  namespace :development do
    task :setup do
      on roles :app do
        invoke 'package:install', 'build-essential curl'
      end
    end
  end
  namespace :git do
    task :setup do
      on roles :app do
        invoke 'package:install', 'git-core'
      end
    end
  end
  namespace :node do
    task :prepare do
      on roles :app do
        invoke 'package:add', 'ppa:chris-lea/node.js'
        invoke 'package:update'
      end
    end
    task :setup do
      on roles :app do
        invoke 'package:install', 'python-software-properties python g++ make nodejs'
      end
    end
  end
end
