load 'deploy'
require 'bundler/capistrano'

set :application, "ualist"
set :repository,  "git@github.com:jakspalding/ualist.git"
set :scm, :git
set :branch, "master"
set :deploy_to, "/var/www/ualist"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

server "ua.jak.io", :web, :app, :db, primary: true

before 'deploy:restart', 'ualist:changeownership'

# I use passenger
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :ualist do
  desc "Changes the ownership of the files so nginx can read them"
  task :changeownership do
    sudo "chown -R jak:www-data #{latest_release}"
  end
end