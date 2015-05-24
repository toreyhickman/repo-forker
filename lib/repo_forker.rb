require "repo_forker/version"
require "repo_forker/configuration"
require "repo_forker/uri_builder"
require "repo_forker/http_client_builder"

module RepoForker
  extend Configuration

  def self.client
    @client ||= HTTPClientBuilder.build
  end

  def self.fork(repo_names = [])
    repo_names.each do |repo_name|
      uri = URI_Builder.build repo_name
    end

    return repo_names
  end
end
