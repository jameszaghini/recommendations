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

## Testing

More & better quality tests

# Example Output

```
ruby bin/main.rb | csvlook
```
```
| jobseeker id | jobseeker name    | job id | job title                 | matching skill count | matching skill percent |
| ------------ | ----------------- | ------ | ------------------------- | -------------------- | ---------------------- |
|            1 | Alice Seeker      |      1 | Ruby Developer            |                    3 |                    100 |
|            1 | Alice Seeker      |      3 | Backend Developer         |                    2 |                     67 |
|            1 | Alice Seeker      |      4 | Fullstack Developer       |                    2 |                     67 |
|            1 | Alice Seeker      |      9 | Python Developer          |                    2 |                     67 |
|            1 | Alice Seeker      |      8 | Web Developer             |                    1 |                     33 |
|            1 | Alice Seeker      |      7 | Data Analyst              |                    1 |                     33 |
|            2 | Bob Applicant     |      2 | Frontend Developer        |                    3 |                    100 |
|            2 | Bob Applicant     |      8 | Web Developer             |                    3 |                    100 |
|            2 | Bob Applicant     |      4 | Fullstack Developer       |                    2 |                     67 |
|            2 | Bob Applicant     |     10 | JavaScript Developer      |                    1 |                     33 |
|            3 | Charlie Jobhunter |      3 | Backend Developer         |                    3 |                    100 |
|            3 | Charlie Jobhunter |      9 | Python Developer          |                    2 |                     67 |
|            3 | Charlie Jobhunter |      1 | Ruby Developer            |                    2 |                     67 |
|            3 | Charlie Jobhunter |      4 | Fullstack Developer       |                    1 |                     33 |
|            3 | Charlie Jobhunter |      7 | Data Analyst              |                    1 |                     33 |
|            4 | Danielle Searcher |      7 | Data Analyst              |                    3 |                    100 |
|            4 | Danielle Searcher |      5 | Machine Learning Engineer |                    3 |                    100 |
|            4 | Danielle Searcher |      6 | Cloud Architect           |                    1 |                     33 |
|            4 | Danielle Searcher |      9 | Python Developer          |                    1 |                     33 |
|            5 | Eddie Aspirant    |      6 | Cloud Architect           |                    2 |                    100 |
|            5 | Eddie Aspirant    |      4 | Fullstack Developer       |                    1 |                     50 |
|            6 | Fiona Candidate   |      7 | Data Analyst              |                    3 |                    100 |
|            6 | Fiona Candidate   |      5 | Machine Learning Engineer |                    2 |                     67 |
|            6 | Fiona Candidate   |      9 | Python Developer          |                    2 |                     67 |
|            6 | Fiona Candidate   |      3 | Backend Developer         |                    1 |                     33 |
|            6 | Fiona Candidate   |      6 | Cloud Architect           |                    1 |                     33 |
|            6 | Fiona Candidate   |      1 | Ruby Developer            |                    1 |                     33 |
|            6 | Fiona Candidate   |      4 | Fullstack Developer       |                    1 |                     33 |
|            7 | George Prospect   |      8 | Web Developer             |                    4 |                    100 |
|            7 | George Prospect   |      2 | Frontend Developer        |                    3 |                     75 |
|            7 | George Prospect   |      4 | Fullstack Developer       |                    3 |                     75 |
|            7 | George Prospect   |      1 | Ruby Developer            |                    1 |                     25 |
|            7 | George Prospect   |     10 | JavaScript Developer      |                    1 |                     25 |
|            8 | Hannah Hunter     |      9 | Python Developer          |                    2 |                    100 |
|            8 | Hannah Hunter     |      3 | Backend Developer         |                    1 |                     50 |
|            8 | Hannah Hunter     |      6 | Cloud Architect           |                    1 |                     50 |
|            8 | Hannah Hunter     |      7 | Data Analyst              |                    1 |                     50 |
|            8 | Hannah Hunter     |      1 | Ruby Developer            |                    1 |                     50 |
|            8 | Hannah Hunter     |      5 | Machine Learning Engineer |                    1 |                     50 |
|            9 | Ian Jobhunter     |     10 | JavaScript Developer      |                    3 |                    100 |
|            9 | Ian Jobhunter     |      2 | Frontend Developer        |                    2 |                     67 |
|            9 | Ian Jobhunter     |      8 | Web Developer             |                    1 |                     33 |
|            9 | Ian Jobhunter     |      4 | Fullstack Developer       |                    1 |                     33 |
|            9 | Ian Jobhunter     |      9 | Python Developer          |                    1 |                     33 |
|           10 | Jane Applicant    |      1 | Ruby Developer            |                    1 |                     50 |
|           10 | Jane Applicant    |      4 | Fullstack Developer       |                    1 |                     50 |
|           10 | Jane Applicant    |      8 | Web Developer             |                    1 |                     50 |
|           10 | Jane Applicant    |      9 | Python Developer          |                    1 |                     50 |
|           10 | Jane Applicant    |     10 | JavaScript Developer      |                    1 |                     50 |
```