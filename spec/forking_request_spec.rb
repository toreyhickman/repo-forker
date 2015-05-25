require "repo_forker"

describe RepoForker::ForkingRequest do

  let(:request_path) { "/path_to_repo?with=options" }
  let(:request) { RepoForker::ForkingRequest.new(request_path) }

  let(:fake_api_key)    { "123456" }
  let(:fake_user_agent) { "my app" }

  before(:each) do
    RepoForker.configure do |config|
      config.api_key    = fake_api_key
      config.user_agent = fake_user_agent
    end
  end

  after(:each) do
    RepoForker.reset
  end

  describe ".new" do
    it "is a kind of Net::HTTP::Post object" do
      expect(request).to be_a_kind_of Net::HTTP::Post
    end

    it "assigns the user-agent header" do
      expect(request["user-agent"]).to eq RepoForker.user_agent
    end

    it "assigns the authorization header" do
      expect(request["authorization"]).to eq "token #{RepoForker.api_key}"
    end

    it "has a path" do
      expect(request.path).to eq request_path
    end
  end
end
