module RepoForker
  class ForkingRequest < Net::HTTP::Post
    def initialize(path)
      super
      assign_user_agent_header
      assign_authorization_header
    end

    private
    def assign_user_agent_header
      self["user-agent"] = RepoForker.user_agent
    end

    def assign_authorization_header
      self["authorization"] = "token #{RepoForker.api_key}"
    end
  end
end
