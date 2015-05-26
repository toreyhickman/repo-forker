require 'repo_forker'

describe RepoForker do
  it "has a version" do
    expect(RepoForker::VERSION).to_not be_nil
  end

  describe "default values" do
    RepoForker::Configuration::VALID_CONFIG_KEYS.each do |key|
      it "has a default #{key}" do
        constant_name = "DEFAULT_#{key.upcase}"
        expected_default_value = RepoForker::Configuration.const_get(constant_name)
        expect(RepoForker.send(key)).to eq expected_default_value
      end
    end
  end

  describe ".configure" do
    after(:each) do
      RepoForker.reset
    end

    RepoForker::Configuration::VALID_CONFIG_KEYS.each do |key|
      it "sets the #{key}" do
        RepoForker.configure do |config|
          config.send("#{key}=", key)
        end

        expect(RepoForker.send(key)).to eq key
      end
    end
  end

  describe ".client" do
    it "returns a Client object" do
      expect(RepoForker.client).to be_an_instance_of RepoForker::Client
    end
  end

  describe ".fork" do
    let(:client) { RepoForker.client }

    let(:repo_1) { "some_repo" }
    let(:repo_2) { "some_other_repo" }
    let(:list)   { [repo_1, repo_2] }

    let(:mock_api_key)     { "123456" }
    let(:mock_source)      { "good_coder" }
    let(:mock_destination) { "helper" }

    before(:each) do
      RepoForker.configure do |config|
        config.api_key     = mock_api_key
        config.source      = mock_source
        config.destination = mock_destination
      end
    end

    after(:each) do
      RepoForker.reset
    end

    it "makes a request to fork each repo in the list" do
      allow(RepoForker).to receive(:record)
      allow(client).to receive(:request)

      list.each do |repo_name|
        fake_uri = double("uri", request_uri: "/path/to/#{repo_name}")
        allow(RepoForker::ForkingURI).to receive(:build).with(repo_name).and_return(fake_uri)

        fake_request = double("request")
        allow(RepoForker::ForkingRequest).to receive(:new).with(fake_uri.request_uri).and_return(fake_request)

        expect(client).to receive(:request).with(fake_request)
      end

      RepoForker.fork list
    end

    it "returns a record of successful and failed requests" do
      list.each do |repo_name|
        fake_uri = double("uri", request_uri: "/path/to/#{repo_name}")
        allow(RepoForker::ForkingURI).to receive(:build).with(repo_name).and_return(fake_uri)

        fake_request = double("request")
        allow(RepoForker::ForkingRequest).to receive(:new).with(fake_uri.request_uri).and_return(fake_request)
      end

      successful_response = double("success", code: "202")
      failed_response = double("fail", code: "404")
      allow(client).to receive(:request).and_return(successful_response, failed_response)

      expect(RepoForker.fork list).to eq({ successful_requests: [repo_1], failed_requests: [repo_2] })
    end
  end
end
