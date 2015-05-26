require "net/http"

require "repo_forker/version"
require "repo_forker/configuration"
require "repo_forker/forking_uri"
require "repo_forker/client"
require "repo_forker/forking_request"

module RepoForker
  extend Configuration

  def self.client
    @client ||= Client.new
  end

  def self.fork(repo_names = [])
    repo_names.each_with_object(new_memo) do |repo_name, memo|
      uri = ForkingURI.build(repo_name)
      request_details = ForkingRequest.new(uri.request_uri)

      response = client.request(request_details)
      record(response, memo, repo_name)
    end
  end

  private
  def self.new_memo
    { successful_requests: [], failed_requests: [] }
  end

  def self.record(response, memo, repo_name)
    key = response.code == "202" ? :successful_requests : :failed_requests
    memo[key] << repo_name
  end
end
