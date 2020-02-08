require 'rails_helper'

RSpec.describe CoordinatesCalculator, type: :service do

  describe '.distance_between_coordinates' do
    subject { described_class.distance_between_coordinates(first_point[:latitude], first_point[:longitude],
                                                           second_point[:latitude], second_point[:longitude]) }
    context 'when both coordinates are the same' do
      let(:first_point) { {latitude: 32.9377784729004, longitude: -117.230392456055} }
      let(:second_point) { first_point }

      it 'should return 0' do
        expect(subject).to be_zero
      end
    end

    context 'when both coordinates are distinct' do
      let(:first_point) { {latitude: 32.9377784729004, longitude: -117.230392456055} }
      let(:second_point) { {latitude: 32.937801361084, longitude: -117.230323791504} }

      it 'should calculate the distance between two coordinates in meters' do
        expect(subject).to eq 6.894801676064742
      end
    end
  end
end
