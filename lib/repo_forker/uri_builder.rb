module RepoForker
  module URI_Builder
    def self.build(repo_name = "")
      uri = URI.parse RepoForker.endpoint
      uri.path = build_path(repo_name)
      uri.query = build_query
      uri
    end

    def self.build_path(repo_name)
      "/repos/#{RepoForker.source}/#{repo_name}/forks"
    end

    def self.build_query
      "organization=#{RepoForker.destination}"
    end
  end
end
