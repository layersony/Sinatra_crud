## Prerequisites
* install gem puma
* install gem postgres 
* install railway cli

## File Creation
1. Create `Procfile` and add the line below
```
web: bundle exec puma -e production
```
2. Open `Gemfile` and the following
```
  group :production do
      gem 'puma', '~> 6.1', '>= 6.1.1'
      gem 'pg', '~> 1.4', '>= 1.4.6'
  end
```
3. Create `.ruby-version` and add your ruby version
```
2.7.4
```

4. Navigate to `config/`

* create `puma.rb` file, add the line below
```
port ENV['PORT'] || 4567
```
* Edit `database.yml` file, replace the production section

create a postgresql database instance in railway app (Project). Under Variables copy and replace the variables with the appropriate counterpart
```
production:
  adapter: postgresql
  database: <database_name>
  username: <username>
  password: <password>
  host: <host>
  port: <port>
  pool: 5
```
* Change environment from `development` to `production` in `environment.rb`
        
## Deploy
1. Open railway app and Deploy from github repository (will start building immediately connected)

2. On bottom left of railway project, Click on `Set up your project locally`

3. Copy the `railway link <auto-generate-link for you project>` and paste it in your local project terminal window

4. Run 
```
railway run bundle exec rake db:migrate
railway run bundle exec rake db:seed

```


