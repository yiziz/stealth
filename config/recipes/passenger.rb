namespace :passenger do
  task :prepare, :version do |task, args|
    # see - https://www.phusionpassenger.com/documentation/Users%20guide%20Nginx.html#install_on_debian_ubuntu
    version = (args and args[:version] or '14.04')
    # 14.04 or 12.04
    os = version == '14.04' ? 'trusty' : 'precise'
    passenger_list = '/etc/apt/sources.list.d/passenger.list'
    on roles :app do
      # ubuntu only
      execute :sudo, 'apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7'
      invoke 'package:install', 'apt-transport-https ca-certificates'
      execute :sudo, 'mkdir -p /etc/apt/sources.list.d/'
      execute :sudo, "echo 'deb https://oss-binaries.phusionpassenger.com/apt/passenger #{os} main' | sudo tee #{passenger_list}"
      execute :sudo, "chown root: #{passenger_list}"
      execute :sudo, "chmod 600 #{passenger_list}"
      invoke 'package:update'
    end
  end
  task :setup do
    on roles :app do
      #invoke 'package:install', 'rake rubygems'
      invoke 'package:install', 'nginx-extras passenger'
    end
  end
  task :restart do
    on roles :app do
      execute "mkdir -p #{current_path}/tmp"
      execute :touch, "#{current_path}/tmp/restart.txt"
    end
  end
end
