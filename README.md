# TinyURLCope-demo

## Getting Started

First, install the required ruby version with rvm

```
rvm install 3.3.3
```

Then, install the required gems for the project. While standing on the root directory run

```
bundle install
```

Next, create the db. To do this you need to have [postgres](https://wiki.postgresql.org/wiki/Homebrew) installed.

```
rails db:create
```

After that run the required migrations for the db

```
rails db:migrate
```

Before running the server, make sure you are running Redis (6.2.0 or up)
```
redis-server
```

and Sidekiq
```
bundle exec sidekiq
```
Lastly, run the server and you are set to go:

```
rails s -p PORTNUMBER
```


## Learn More

If you want to learn more [here](https://guides.rubyonrails.org/getting_started.html) is a detailed tutorial on how to create and run a rails project
