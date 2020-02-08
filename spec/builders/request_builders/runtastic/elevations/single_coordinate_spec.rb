require 'rails_helper'

RSpec.describe RequestBuilders::Runtastic::Elevations::SingleCoordinate do
  describe '#build' do
    subject { described_class.new(latitude, longitude).build }

    let(:latitude) { 38.9199256896973 }
    let(:longitude) { -121.019874572754 }

    let(:target_url) { "https://codingcontest.runtastic.com/api/elevations/#{latitude}/#{longitude}" }

    it 'should return a request object with proper attributes"' do
      expect(subject).to be_kind_of RequestBuilders::Runtastic::Request

      expect(subject.method).to eq(:get)
      expect(subject.url).to eq(target_url)
    end
  end
end
