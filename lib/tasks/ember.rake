require Rake.original_dir + '/lib/recipes/base.rb'
namespace :ember do
  config = YAML.load_file 'config/ember.yml'
  cli_config = config['cli']
  cli_repo_url = cli_config['repo_url']
  link_dir = cli_config['link_dir']
  deploy_dir = config['deploy_dir']
  dist_dir = "#{deploy_dir}/dist"
  repo_url = config['repo_url']
  task :setup, :commit do |task, args|
    commit = (args and args[:commit] or 'e14d339496689263ec96d3e4b54c55d404f50513')
    Rake::Task['ember:unlink'].invoke
    sh "git clone #{cli_repo_url} #{link_dir}"
    sh "(cd #{link_dir} && git reset --hard #{commit})" if commit.present?
    sh "(cd #{link_dir} && sudo npm link)"
  end
  task :unlink do
    sh "sudo rm -rf #{link_dir}"
  end
  task :build, :env do |task, args|
    env = (args and args[:env] or 'production')
    sh "(cd #{deploy_dir} && npm install && bower install)"
    sh "(cd #{deploy_dir} && ember build #{env and "--environment=#{env}"} --output-path=#{dist_dir})"
  end
  task :clone, :branch do |task, args|
    branch = (args and args[:branch])
    sh "rm -rf #{deploy_dir}"
    sh "git clone #{branch and "-b #{branch}"} #{repo_url} #{deploy_dir}"
  end
  task :deploy, :env, :branch do |task, args|
    env = (args and args[:env] or 'production')
    branch = (args and args[:branch])
    # clone ember git
    Rake::Task['ember:clone'].invoke((branch or env))
    # build ember app
    Rake::Task['ember:build'].invoke env
    # push ember dist to AWS S3
    sh "(cd #{deploy_dir} && grunt)"
  end
  namespace :grunt do
    task :setup do
      sh "(cd #{deploy_dir} && npm install grunt-s3 --save-dev)"
      template 'grunt_file.erb', "#{deploy_dir}/Gruntfile.js"
    end
  end
end
