require "repo_forker/version"
require "repo_forker/configuration"
require "repo_forker/http_client_builder"

module RepoForker
  extend Configuration

  def self.client
    @client ||= HTTPClientBuilder.build
  end

end
