# Setup

Install asdf
https://asdf-vm.com/guide/getting-started.html

Install Ruby 3.3.4
```
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf install ruby 3.3.4
```
Install dependencies
```
bundle install
```

# Running the app

In the root of the project directory run

```
bundle exec ruby bin/main.rb
```

If you have `csvkit` installed, prettier output is easy with

```
bundle exec ruby bin/main.rb | csvlook
```

# Running the tests

```
bundle exec rspec
```

# TODO

Things I should have done but have run out of time

## Optimisation

I would consider doing one or more of these based on where the bottlenecks are: 

* Use a database to do the matching
* Use sidekiq to process the files in parallel
eg half the job seekers processed in one job, the other half in another job then combine results
* Put both CSVs in an AWS S3 bucket that starts a lambda to process the data.  Consider a language other than Ruby for the lambda if it's faster and receiving the results of processing is time critical 
* Profile the code to find bottlenecks and improve as necessary
* Look for a gem that processes csvs faster than the csv gem

## Type safety

Use rbs or sorbet to ensure the model objects are created with the correct types

## Error handling

I'd use more error handling and test accordingly

