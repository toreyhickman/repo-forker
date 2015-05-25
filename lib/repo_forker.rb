require "repo_forker/version"
require "repo_forker/configuration"
require "repo_forker/uri_builder"
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
      uri = URI_Builder.build repo_name
    end

    return repo_names
  end
end
