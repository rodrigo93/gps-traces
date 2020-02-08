require 'rails_helper'

RSpec.describe RequestBuilders::Runtastic::Elevations::BulkCoordinate do
  describe '#build' do
    subject { described_class.new(coordinates).build }

    let(:coordinates) do
      [
          { "latitude": 32.9377784729004, "longitude": -117.230392456055 },
          { "latitude": 32.937801361084, "longitude": -117.230323791504 }
      ]
    end

    let(:target_url) { "https://codingcontest.runtastic.com/api/elevations/bulk" }

    it 'should return a request object with proper attributes and body' do
      expect(subject).to be_kind_of RequestBuilders::Runtastic::Request

      expect(subject.method).to eq(:post)
      expect(subject.url).to eq(target_url)
      expect(subject.body).to eq(coordinates)
    end
  end
end
