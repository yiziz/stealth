namespace :nginx do
  nginx_path = "/etc/nginx/"
  nginx_temp = "/tmp/nginx_conf"

  #task :setup do
  #  on roles :app do
  #    invoke 'package:add', 'ppa:nginx/stable'
  #    invoke 'package:update'
  #    invoke 'package:install', 'nginx'
  #    execute :sudo, 'mkdir -p /usr/share/nginx/logs/'
  #  end
  #end
  #after "deploy:install", "nginx:install"

  desc "Configue nginx for this app"
  task :configure do
    on roles(:web) do
      template "nginx_passenger.erb", nginx_temp
      execute :sudo, :mv, nginx_temp, "#{nginx_path}/nginx.conf"
    end
    #invoke 'nginx:restart'
  end
  
  %w[start stop restart status].each do |command|
    desc "#{command} nginx"
    task command do
      on roles(:web) do
        execute :sudo, :service, "nginx #{command}"
      end
    end
  end
end
