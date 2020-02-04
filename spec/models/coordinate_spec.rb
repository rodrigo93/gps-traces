require 'rails_helper'

RSpec.describe Coordinate, type: :model do
  describe ".initialize" do
    subject { described_class.new(latitude: latitude, longitude: longitude) }

    context 'when all required arguments are passed' do
      let(:latitude) { 32.9377784729004 }
      let(:longitude) { -117.230392456055 }

      it 'should not raise any errors' do
        expect { subject }.not_to raise_error
      end

      it 'should initialize it with "latitude" and "longitude" set' do
        expect(subject.latitude).to eq latitude
        expect(subject.longitude).to eq longitude
      end
    end
  end

  describe '#valid?' do
    subject { described_class.new(latitude: latitude, longitude: longitude).valid? }

    context 'when "latitude" and "longitude" are present' do
      let(:latitude) { 32.9377784729004 }
      let(:longitude) { -117.230392456055 }

      it 'should return true' do
        expect(subject).to be_truthy
      end
    end

    context 'when "latitude" is not present' do
      let(:latitude) { nil }
      let(:longitude) { -117.230392456055 }

      it 'should return false' do
        expect(subject).to be_falsey
      end
    end

    context 'when "longitude" is not present' do
      let(:latitude) { 32.9377784729004 }
      let(:longitude) { nil }

      it 'should return false' do
        expect(subject).to be_falsey
      end
    end
  end

  describe '#invalid?' do
    subject { described_class.new(latitude: latitude, longitude: longitude).invalid? }

    context 'when "latitude" and "longitude" are present' do
      let(:latitude) { 32.9377784729004 }
      let(:longitude) { -117.230392456055 }

      it 'should return false' do
        expect(subject).to be_falsey
      end
    end

    context 'when "latitude" is not present' do
      let(:latitude) { nil }
      let(:longitude) { -117.230392456055 }

      it 'should return true' do
        expect(subject).to be_truthy
      end
    end

    context 'when "longitude" is not present' do
      let(:latitude) { 32.9377784729004 }
      let(:longitude) { nil }

      it 'should return true' do
        expect(subject).to be_truthy
      end
    end
  end
end
