module RepoForker
  module Configuration
    def self.extended(base)
      base.reset
    end

    VALID_CONNECTION_KEYS = [:endpoint, :user_agent]
    VALID_OPTIONS_KEYS = [:api_key, :source, :destination]
    VALID_CONFIG_KEYS = VALID_CONNECTION_KEYS + VALID_OPTIONS_KEYS

    DEFAULT_ENDPOINT = "https://api.github.com/"
    DEFAULT_USER_AGENT = "RepoForker Ruby Gem #{RepoForker::VERSION}"

    DEFAULT_API_KEY = nil
    DEFAULT_SOURCE = nil
    DEFAULT_DESTINATION = nil

    attr_accessor *VALID_CONFIG_KEYS

    def configure
      yield self if block_given?
    end

    def reset
      self.endpoint = DEFAULT_ENDPOINT
      self.user_agent = DEFAULT_USER_AGENT
      self.api_key = DEFAULT_API_KEY
      self.source = DEFAULT_SOURCE
      self.destination = DEFAULT_DESTINATION
    end
  end
end
