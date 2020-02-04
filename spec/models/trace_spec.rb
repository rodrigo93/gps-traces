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

  describe '#parsed' do
    let!(:trace) { Trace.create!(coordinates: [{"latitude":40.780517578125,"longitude":-73.9483489990234}].to_json) }

    it 'should return all coordinates as Hash' do
      trace.parsed.each do |parsed_coordinate|
        expect(parsed_coordinate).to be_kind_of Hash
      end
    end
  end
end
