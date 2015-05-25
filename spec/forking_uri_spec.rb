require 'repo_forker'

describe RepoForker::ForkingURI do

  let(:fake_api_key)     { "123456" }
  let(:fake_source)      { "good-coder" }
  let(:fake_destination) { "helper" }
  let(:fake_repo_to_fork)     { "cool-library" }

  before(:each) do
    RepoForker.configure do |config|
      config.api_key     = fake_api_key
      config.source      = fake_source
      config.destination = fake_destination
    end
  end

  after(:each) do
    RepoForker.reset
  end

  describe ".build" do
    it "is a kind of Ruby URI::HTTPS object" do
      expect(RepoForker::ForkingURI.build fake_repo_to_fork).to be_a_kind_of URI::HTTPS
    end

    it "has a path to request forking the repository" do
      expected_path = "/repos/#{fake_source}/#{fake_repo_to_fork}/forks"
      built_uri = RepoForker::ForkingURI.build(fake_repo_to_fork)

      expect(built_uri.path).to eq expected_path
    end

    it "has a query string to specify the destination organization" do
      expected_query_string = "organization=#{fake_destination}"
      built_uri = RepoForker::ForkingURI.build(fake_repo_to_fork)

      expect(built_uri.query).to eq expected_query_string
    end

    it "has a properly formatted request uri" do
      expected_request_uri = "/repos/#{fake_source}/#{fake_repo_to_fork}/forks?organization=#{fake_destination}"
      built_uri = RepoForker::ForkingURI.build(fake_repo_to_fork)

      expect(built_uri.request_uri).to eq expected_request_uri
    end
  end
end
