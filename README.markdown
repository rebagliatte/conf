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
  cp config/secrets.example.yml config/secrets.yml
  ```

4. Create your development's database
  ```
  rake db:create
  ```

5. Ask for the latest dump from production's database and load it on your development database
  ```
  psql confnu_development < ~/confnu_production_latest_dump.sql
  ```

6. Sync your S3 bucket with production's
  ```
  rake s3:create_development_bucket
  ```

7. Start the server
  ```
  rails s
  ```

8. Visit your localhost through lvh.me
  This url points to your localhost and will enable subdomain usage from your development environment
  ```
  open http://lvh.me:3000/
  ```

7. Profit!

## To create your first conference:

1. Visit `http://lvh.me:3000/admin/conferences/new` and create a conference
2. Visit the conference through its subdomain. If the conference's subdomain was `rcu` you'll be able to access it on `http://rcu.lvh.me:3000`.

## To ssh the servers through aliases

```
vim ~/.ssh/config
```

With this contents:

```
Host confnu-production
  Hostname 173.230.137.247
  User deployer
  IdentityFile ~/.ssh/id_rsa

Host confnu-staging
  Hostname 192.155.94.162
  User deployer
  IdentityFile ~/.ssh/id_rsa
```

## To backup production DB

```
ssh deploy@confnu-production
cd db_backups
pg_dump -U deploy -F c -b -v -f latest.backup conf_production
exit
scp deploy@confnu-production:/home/deploy/db_backups/latest.backup ~/
```

## To load the latest dump on your development DB

```
bundle exec rake db:drop
bundle exec rake db:create
pg_restore --dbname=conf_development --verbose ~/latest.backup --clean
bundle exec rake db:migrate
```

To sync the development S3 bucket

```
bundle exec rake s3:sync_development_bucket
```

## To load the latest dump on staging

```
scp ~/latest.backup deploy@confnu-staging:/home/deploy/db_backups
cap staging puma:stop
ssh deploy@confnu-staging
pg_restore --dbname=conf_staging --verbose /home/deploy/db_backups/latest.backup --clean
exit
cap staging puma:start
```

To sync the staging S3 bucket

```
bundle exec rake s3:sync_staging_bucket
```
