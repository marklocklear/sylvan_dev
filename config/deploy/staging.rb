# This deploy recipe will deploy a project from a GitHub repo to a production server
#
# GitHub settings #######################################################################################
default_run_options[:pty] = true

# Change this to the name of the project.  It should match the name of the Git repo.
# This will set the name of the project directory and become the subdomain
set :project, 'sylvansport' 

set :github_user, "scullygroup" # Your GitHub username
set :domain_name, "scullystaging.com" # should be something like mydomain.com
set :user, 'scullygroup' # Webbynode username
set :domain, '208.88.125.22' # Webbynode IP address

# api setting for adding webbynode dns entry
set :api_token, 'dc2e7782ad5e284e05466382ab53ce6d26dbf047'
set :record_id, '265'

#### You shouldn't need to change anything below ########################################################
default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :repository,  "git@github.com:#{github_user}/#{project}.git" #GitHub clone URL
set :scm, "git"
set :scm_passphrase, "" # This is the passphrase for the ssh key on the server deployed to
set :branch, "master"
set :scm_verbose, true
set :subdomain, "#{project}.#{domain_name}"
set :applicationdir, "/home/#{project}" # set this to where the application will be deployed

set :keep_releases, 1

# Don't change this stuff, but you may want to set shared files at the end of the file ##################
# deploy config
set :deploy_to, applicationdir
set :deploy_via, :remote_cache
 
# roles (servers)
role :app, domain
role :web, domain
role :gateway, domain
role :db,  domain, :primary => true

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end

namespace :webbynode do
  desc "Setup New Project"
  task :setup do
    config_vhost
    apache_reload
    add_dns
  end
  
  desc "Configure VHost"
  task :config_vhost do
    vhost_config =<<-EOF
<VirtualHost *:80>
  ServerName #{subdomain}
  RailsEnv staging
  DocumentRoot #{deploy_to}/current/public
</VirtualHost>
    EOF
    put vhost_config, "src/vhost_config"
    sudo "mv src/vhost_config /etc/apache2/sites-available/#{project}"
    sudo "chown root:root /etc/apache2/sites-available/#{project}"
    sudo "a2ensite #{project}"
    sudo "mkdir /home/#{project}"
    sudo "chown #{user}:#{user} /home/#{project}"
  end
  
  desc "Reload Apache"
  task :apache_reload do
    sudo "/etc/init.d/apache2 reload"
  end
  
  desc "Add DNS entry"
  task :add_dns do
    run "curl -F 'email=patrick@scullytown.com' -F 'token=#{api_token}' https://manager.webbynode.com/api/xml/dns/#{record_id}/records/new -F 'record[type]=A' -F 'record[name]=#{project}' -F 'record[data]=#{domain}'"
  end
  
  namespace :memcached do
    desc "Start Memcached"
    task :start do
      sudo "/etc/init.d/memcached start"
    end
    
    desc "Stop Memcached"
    task :stop do
      sudo "/etc/init.d/memcached stop"
    end
    
    desc "Restart Memcached"
    task :restart do
      sudo "/etc/init.d/memcached restart"
    end
  end
  
end

# additional settings
#default_run_options[:pty] = true  # Forgo errors when deploying from windows
#ssh_options[:keys] = %w(/Path/To/id_rsa)            # If you are using ssh_keys
#set :chmod755, "app config db lib public vendor script script/* public/disp*"
set :use_sudo, false
 
# Optional tasks ##########################################################################################
# for use with shared files (e.g. config files)
after "deploy:update_code" do
  run "rm -f #{release_path}/public/robots.txt"
  run "ln -s /home/scullygroup/src/robots.txt #{release_path}/public"
  # run "ln -s #{shared_path}/filmstrips #{release_path}/public/"
 # run "ln -s #{shared_path}/galleries #{release_path}/public/"
 run "ln -s #{shared_path}/assets #{release_path}/public/"
end