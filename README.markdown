Confnu
=======

## To get your environment up and running:

1. Clone the repo
  ```
  git clone git@github.com:rebagliatte/conf.git
  ```

2. Install the required gems
  ```
  cd conf
  bundle
  ```

3. Copy over the config file from the example file and fill it in with the required credentials
  ```
  cp config/application.example.yml config/application.yml
  ```

4. Setup your database
  ```
  rake db:setup
  rake db:seed
  ```

5. Start the server
  ```
  rails s
  ```

6. Visit your localhost through lvh.me
  This url points to your localhost and will enable subdomain usage from your development environment
  ```
  open http://lvh.me:3000/
  ```

7. Profit!

## To create your first conference:

1. Visit `http://lvh.me:3000/admin/conferences/new` and create a conference
2. Visit the conference through its subdomain. If the conference's subdomain was `rcu` you'll be able to access it on `http://rcu.lvh.me:3000`. You may also just use the generated url displayed on the app homepage on `http://lvh.me:3000/`
