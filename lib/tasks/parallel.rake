namespace :parallel do
  desc 'Prepare DB for parallel tests'
  task :migrate do
    Rake::Task['parallel:create'].execute
    Rake::Task['parallel:prepare'].execute
  end
end
