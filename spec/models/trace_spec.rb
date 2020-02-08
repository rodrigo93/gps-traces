require 'rails_helper'

RSpec.describe Trace, type: :model do
  describe 'validations' do
    context 'when validating coordinates JSON' do
      it { is_expected.to validate_presence_of :coordinates }

      shared_context 'a trace with invalid coordinates' do
        it 'should be invalid' do
          expect(trace).to be_invalid
        end

        it 'should have error on :coordinates' do
          trace.valid?

          expect(trace.errors[:coordinates]).to be_present
        end

        it 'should have error "The JSON must be well formatted and all latitudes and longitudes must be present" message' do
          trace.valid?

          expect(trace.errors[:coordinates]).to include("The JSON must be well formatted and all latitudes and longitudes must be present")
        end
      end

      context 'and there is no longitude' do
        let(:trace) { Trace.new(coordinates: [{"latitude": -73.9483489990234}].to_json) }

        it_should_behave_like 'a trace with invalid coordinates'
      end

      context 'and there is no latitude' do
        let(:trace) { Trace.new(coordinates: [{"longitude": -73.9483489990234}].to_json) }

        it_should_behave_like 'a trace with invalid coordinates'
      end

      context 'and it receives a malformed JSON' do
        let(:trace) { Trace.new(coordinates: [{"foo": 'bar'}].to_json) }

        it_should_behave_like 'a trace with invalid coordinates'
      end
    end
  end

  describe 'callbacks' do
    describe 'before_save :update_distances' do
      context 'when the Trace is updated' do
        context 'and it does not have distances calculated' do
          let(:trace) { Trace.create(coordinates: [{"latitude": -73.9483489990234, "longitude": -73.9483489990234}].to_json) }

          it 'should calculate all "distances" for each coordinate' do
            trace.coordinates_as_hash.each do |coordinate|
              expect(coordinate.has_key?(:distance)).to be_truthy
            end
          end
        end

        context 'and it has distances calculated' do
          let(:old_coordinates) do
            [{"latitude": 32.9377784729004, "longitude": -117.230392456055, "distance": 0},
             {"latitude": 32.937801361084, "longitude": -117.230323791504, "distance": 6},
             {"latitude": 32.9378204345703, "longitude": -117.230278015137, "distance": 11}].to_json
          end

          let(:trace) { Trace.create(coordinates: old_coordinates) }

          let(:new_coordinates) do
            [{"latitude": 32.9378204345703, "longitude": -117.230239868164},
             {"latitude": 32.9378318786621, "longitude": -117.230209350586},
             {"latitude": 32.9378814697266, "longitude": -117.230102539062}].to_json
          end

          let(:expected_new_coordinates_with_distances) do
            [{"latitude": 32.9378204345703, "longitude": -117.230239868164, "distance": 0},
             {"latitude": 32.9378318786621, "longitude": -117.230209350586, "distance": 4},
             {"latitude": 32.9378814697266, "longitude": -117.230102539062, "distance": 16}].to_json
          end

          it 'should calculate all "distances" for each coordinate' do
            trace.update(coordinates: new_coordinates)

            trace.reload

            expect(trace.coordinates).to eq expected_new_coordinates_with_distances

            trace.coordinates_as_hash.each do |coordinate|
              expect(coordinate.has_key?(:distance)).to be_truthy
              expect(coordinate[:distance]).not_to be_blank
            end
          end
        end
      end

      context 'when coordinates did not changed' do
        let(:trace) { Trace.create(coordinates: [{"latitude": -73.9483489990234, "longitude": -73.9483489990234}].to_json) }

        it 'should not update "coordinates" attribute' do
          old_coordinates = trace.coordinates

          trace.touch

          expect(old_coordinates).to eq(trace.coordinates)
        end
      end

      context 'when the Trace is created' do
        let(:trace) { Trace.create(coordinates: [{"latitude": -73.9483489990234, "longitude": -73.9483489990234}].to_json) }

        it 'should calculate all "distances" for each coordinate' do
          trace.coordinates_as_hash.each do |coordinate|
            expect(coordinate.has_key?(:distance)).to be_truthy
          end
        end
      end
    end
  end

  describe '#coordinates_as_hash' do
    let!(:trace) { Trace.create!(coordinates: [{"latitude": 40.780517578125, "longitude": -73.9483489990234}].to_json) }

    it 'should return all coordinates as Hash' do
      trace.coordinates_as_hash.each do |parsed_coordinate|
        expect(parsed_coordinate).to be_kind_of Hash
      end
    end
  end

  describe '#distances_calculated?' do
    subject { trace.distances_calculated? }

    let!(:trace) { Trace.create(coordinates: coordinates) }

    context 'when all distances are calculated' do
      let(:coordinates) do
        [{"latitude": 32.9377784729004, "longitude": -117.230392456055, "distance": 0},
         {"latitude": 32.937801361084, "longitude": -117.230323791504, "distance": 6},
         {"latitude": 32.9378204345703, "longitude": -117.230278015137, "distance": 11}].to_json
      end

      it 'should return true' do
        expect(subject).to be_truthy
      end
    end

    context 'when no distance is calculated' do
      let(:coordinates) do
        [{"latitude": 32.9377784729004, "longitude": -117.230392456055},
         {"latitude": 32.937801361084, "longitude": -117.230323791504},
         {"latitude": 32.9378204345703, "longitude": -117.230278015137}].to_json
      end

      it 'should return false' do
        trace.update_column(:coordinates, coordinates)

        expect(subject).to be_falsey
      end
    end
  end

  describe '#elevations_calculated?' do
    subject { trace.elevations_calculated? }

    let!(:trace) { Trace.create(coordinates: coordinates) }

    context 'when all elevations are calculated' do
      let(:coordinates) do
        [{ "latitude": 32.9377784729004, "longitude": -117.230392456055, "distance": 0, "elevation": 4139 },
         { "latitude": 32.937801361084, "longitude": -117.230323791504, "distance": 6, "elevation": 4139 },
         { "latitude": 32.9378204345703, "longitude": -117.230278015137, "distance": 11, "elevation": 4139 }].to_json
      end

      it 'should return true' do
        expect(subject).to be_truthy
      end
    end

    context 'when no elevation is calculated' do
      let(:coordinates) do
        [{"latitude": 32.9377784729004, "longitude": -117.230392456055},
         {"latitude": 32.937801361084, "longitude": -117.230323791504},
         {"latitude": 32.9378204345703, "longitude": -117.230278015137}].to_json
      end

      it 'should return false' do
        trace.update_column(:coordinates, coordinates)

        expect(subject).to be_falsey
      end
    end
  end
end
