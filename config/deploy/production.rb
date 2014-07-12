application_master = '173.230.137.247'

role :app, application_master
role :web, application_master
role :db,  application_master

set :rails_env, 'production'
set :host, 'confnu.com'
