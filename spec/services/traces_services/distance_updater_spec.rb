require 'rails_helper'

RSpec.describe TracesServices::DistanceUpdater, type: :service do

  describe '#call' do
    subject { described_class.new(trace).call }

    let(:trace) { Trace.create(coordinates: coordinates) }

    let(:coordinates) do
      [{"latitude": 32.9378204345703, "longitude": -117.230239868164},
       {"latitude": 32.9378318786621, "longitude": -117.230209350586},
       {"latitude": 32.9378814697266, "longitude": -117.230102539062}].to_json
    end

    let(:expected_coordinates_with_distances) do
      [{"latitude": 32.9378204345703, "longitude": -117.230239868164, "distance": 0},
       {"latitude": 32.9378318786621, "longitude": -117.230209350586, "distance": 4},
       {"latitude": 32.9378814697266, "longitude": -117.230102539062, "distance": 16}].to_json
    end

    it 'should calculate all "distances" for each coordinate' do
      subject

      expect(trace.coordinates).to eq expected_coordinates_with_distances

      trace.coordinates_as_hash.each do |coordinate|
        expect(coordinate.has_key?(:distance)).to be_truthy
        expect(coordinate[:distance]).not_to be_blank
      end
    end
  end
end
