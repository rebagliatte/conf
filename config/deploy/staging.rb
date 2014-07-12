application_master = '192.155.94.162'

role :app, application_master
role :web, application_master
role :db,  application_master

set :rails_env, 'staging'
set :host, 'confnu-staging.com'
set :keep_releases, 2
