# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'conf'
set :repo_url, 'git@github.com:rebagliatte/conf.git'

# Ask for a branch, default one is :master
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/deploy/apps/conf'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :info

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/application.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Set ssh user
set :user, 'deploy'
set :ssh_options, {
  user: fetch(:user)
}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# For capistrano-puma
set :puma_init_active_record, true

# For capistrano-bundler
set :bundle_path, -> { shared_path.join('vendor','bundle') }
set :bundle_flags, '--deployment'
