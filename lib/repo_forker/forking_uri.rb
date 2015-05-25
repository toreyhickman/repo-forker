module RepoForker
  class ForkingURI < URI::HTTPS
    def self.create(repo_name)
      build(build_params(repo_name))
    end

    private
    def self.build_params(repo_name)
      { :path  => build_path(repo_name),
        :host  => build_host,
        :query => build_query }
    end

    def self.build_path(repo_name)
      "/repos/#{RepoForker.source}/#{repo_name}/forks"
    end

    def self.build_host
      RepoForker.endpoint.sub(/\w+:\/\//, "")
    end

    def self.build_query
      "organization=#{RepoForker.destination}"
    end
  end
end
