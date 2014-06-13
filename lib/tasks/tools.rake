namespace :tools do
  task :setup do
    Rake::Task['tools:development:setup']
    Rake::Task['tools:git:setup']
    Rake::Task['tools:node:prepare']
    Rake::Task['tools:node:setup']
  end
  namespace :development do
    task :setup do
      Rake::Task['package:install'].invoke 'build-essential curl'
    end
  end
  namespace :git do
    task :setup do
      Rake::Task['package:install'].invoke 'git-core'
    end
  end
  namespace :node do
    task :prepare do
      Rake::Task['package:add'].invoke 'ppa:chris-lea/node.js'
      Rake::Task['package:update'].invoke
    end
    task :setup do
      Rake::Task['package:install'].invoke 'python-software-properties python g++ make nodejs'
      sh 'sudo npm install -g bower'
    end
  end
end
