require "repo_forker/version"
require "repo_forker/configuration"
require "repo_forker/forking_uri"
require "repo_forker/client"
require "repo_forker/forking_request"
require "net/http"


module RepoForker
  extend Configuration

  def self.client
    @client ||= Client.new
  end

  def self.fork(repo_names = [])
    repo_names.each do |repo_name|
      uri = ForkingURI.build(repo_name)
      request_details = ForkingRequest.new(uri.request_uri)

      client.request(request_details)
    end

    return repo_names
  end
end
