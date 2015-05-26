# RepoForker

![Travis CI Build Status](https://api.travis-ci.org/toreyhickman/repo-forker.svg?branch=master)

This gem is written to facilitate the forking of a list of GitHub repositories from one user or organization to another.


## Installation
Add this line to your application's Gemfile:

```ruby
gem 'repo_forker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install repo_forker


## Usage
```ruby
RepoForker.configure do |config|
  config.api_key = "123456"
  config.source  = "some-organization"
  config.destination = "another-organization"
end

repo_list = ["some-repo", "some-other-repo"]

RepoForker.fork(repo_list)
# => { :successful_requests => ["some-repo"], :failed_requests => ["some-other-repo"] }
```

*Figure 1*. Example configuration and use of  RepoForker.

In order for RepoForker to make requests to the GitHub API to fork repositories, it must be configured with a GitHub API key, source user/organization, and a destination user/organization.  After configuration is complete, prepare a list of repository names and tell RepoForker to fork the repositories.  (see Figure 1)


## Contributing
If you'd like to help improve RepoForker by adding a new feature, please fork the repository and submit a pull request for your feature branch. Also, please report any bugs that you find.