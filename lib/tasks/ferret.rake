namespace :ferret do
  desc 'Rebuild ferret search index'
  task :reindex => :environment do    
    puts "Reindexing site..."
    Idea.rebuild_index
    Category.rebuild_index
  end
end

desc 'Deploy site to heroku'
task :deploy do
  puts "Deploying site to heroku..."
  sh "git push heroku master"
  sh "heroku rake ferret:reindex"
end