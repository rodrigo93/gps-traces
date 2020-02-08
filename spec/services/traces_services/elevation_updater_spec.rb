require 'rails_helper'

RSpec.describe TracesServices::ElevationUpdater, type: :service do

  describe '#call' do
    subject { described_class.new(trace).call }

    let(:trace) { Trace.create(coordinates: coordinates) }

    let(:coordinates) do
      [{"latitude": 32.9378204345703, "longitude": -117.230239868164, "distance": 0},
       {"latitude": 32.9378318786621, "longitude": -117.230209350586, "distance": 4},
       {"latitude": 32.9378814697266, "longitude": -117.230102539062, "distance": 16}].to_json
    end

    # Elevation values are not real due tests purpose
    let(:expected_coordinates_with_elevations) do
      [{"latitude": 32.9378204345703, "longitude": -117.230239868164, "distance": 0, "elevation": 1},
       {"latitude": 32.9378318786621, "longitude": -117.230209350586, "distance": 4, "elevation": 2},
       {"latitude": 32.9378814697266, "longitude": -117.230102539062, "distance": 16, "elevation": 3}].to_json
    end

    let(:headers) do
      {
          'Accept' => 'application/json;',
          'Content-Type' => 'application/json'
      }
    end
    let(:endpoint) { 'https://codingcontest.runtastic.com/api/elevations/bulk' }
    let(:response) { '[1, 2, 3]' }

    let(:raw_request_body) { JSON.parse(coordinates) }

    before :each do
      stub_request(:post, endpoint).
          with(body: raw_request_body.to_json).
          to_return(status: 200, body: response)
    end

    it 'should calculate all "elevations" for each coordinate' do
      subject

      expect(trace.coordinates).to eq expected_coordinates_with_elevations

      trace.coordinates_as_hash.each do |coordinate|
        expect(coordinate.has_key?(:elevation)).to be_truthy
        expect(coordinate[:elevation]).not_to be_blank
      end
    end
  end
end
