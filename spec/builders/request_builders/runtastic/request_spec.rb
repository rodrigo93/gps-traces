require 'rails_helper'

RSpec.describe RequestBuilders::Runtastic::Request do
  subject { described_class.new(method, url) }

  let(:method) { :get }
  let(:url) { 'https://codingcontest.runtastic.com/api/some-endpoint' }

  let(:headers) do
    {'Accept' => 'application/json;',
     'Content-Type' => 'application/json'}
  end

  describe '#run' do
    let(:response) { '1234' }

    before(:each) do
      stub_request(:get, url).
          with(headers: headers).
          to_return(status: 200, body: response)
    end

    it 'should return response successfully' do
      response = subject.run

      expect(response).to be_kind_of(RequestBuilders::Runtastic::Response)
      expect(response.result).to eq '1234'
    end
  end
end
