
# Rails app template

* Rail 5.2
* Postgres
* Active Job using Delayed Job
* Active Mailer using MailCatcher in Dev / SMTP in Prod
* Webpacker (Asset Pipeline still needs dissabling though)
* Stimulus JS
* Tailwind CSS
* Font Awesome 5 Pro
* Minitest
* Pundit.

App already contains User, Account models with ability to `/register` `/login` `/logout`.




# Background jobs

These are executed via Active Job, using the built-in in-memory queuing system, this is for emails that need to immediately be sent (ie. password resets)... and for use in development.

Delayed Job is available as a backend for jobs as needed by setting `self.queue_adapter = :delayed_job` in the job file.

Since Delayed Job needs its own process to run, that can be run with either:

* `rake jobs:work` (only useful for development environments)
* `bin/delayed_job start` script via the `daemons` gem.


## Email Setup

To test emails in development, we use Mailcatcher https://mailcatcher.me.

- gem install mailcatcher
- mailcatcher
- go to http://localhost:1080
- send mail through smtp://localhost:1025 (we've already set the app up to do this)

**don't put mailcatcher in the gemfile. Install it directly via** `gem install mailcatcher`.


## Running Web App (Puma), Mailcatcher, Background Jobs, etc

In development, use `gem install foreman`. Do *not* add this to the Gemfile. Then run `foreman start`.

This will reference the `Procfile` in the project's root.


## Migrations and Switch Branches

Always run `rake db:migrate` when your in a branch making changes.

When switching branches, run `rake db:schema:load` to reset the database for the branch change so your database isn't polluted with changes that may be happening in parallel in another branch.

This will delete your data. Over time, we need to build out some seeds in `seeds.rb` to help create data to use in development.
