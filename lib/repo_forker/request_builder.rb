module RepoForker
  module RequestBuilder
    def self.build(path)
      request = Net::HTTP::Post.new(path)
      assign_user_agent_header(request)
      assign_authorization_header(request)
      return request
    end

    private
    def self.assign_user_agent_header(request)
      request["user-agent"] = RepoForker.user_agent
    end

    def self.assign_authorization_header(request)
      request["authorization"] = "token #{RepoForker.api_key}"
    end
  end
end
