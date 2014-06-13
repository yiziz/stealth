namespace :package do
  task :add, :repo do |task, args|
    Rake::Task['package:apt:add'].invoke args[:repo]
  end
  task :install, :packages do |task, args|
    Rake::Task['package:apt:install'].invoke args[:packages]
  end
  task :update do |task, args|
    Rake::Task['package:apt:update'].invoke
  end
  namespace :apt do
    task :add, :repo do |task, args|
      sh "sudo add-apt-repository #{args[:repo]}"
    end
    task :install, :packages do |task, args|
      sh "sudo apt-get install -y #{args[:packages]}"
    end
    task :update do |task, args|
      sh 'sudo apt-get update'
    end
  end
end
