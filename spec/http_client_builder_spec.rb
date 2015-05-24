require 'repo_forker'

describe RepoForker::HTTPClientBuilder do
  let(:client) { RepoForker::HTTPClientBuilder.build }

  it "returns a Ruby Net::HTTP object" do
    expect(client).to be_an_instance_of Net::HTTP
  end

  it "has the host of the GitHub api" do
    expect(client.address).to eq "api.github.com"
  end

  it "uses 443 as its port" do
    expect(client.port).to eq 443
  end
end
