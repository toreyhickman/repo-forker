require "repo_forker/version"
require "repo_forker/configuration"
require "repo_forker/forking_uri"
require "repo_forker/client"
require "repo_forker/request_builder"
require "net/http"


module RepoForker
  extend Configuration

  def self.client
    @client ||= Client.create
  end

  def self.fork(repo_names = [])
    repo_names.each do |repo_name|
      uri = ForkingURI.create repo_name
    end

    return repo_names
  end
end
