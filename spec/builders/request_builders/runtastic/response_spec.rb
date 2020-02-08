require 'rails_helper'

RSpec.describe RequestBuilders::Runtastic::Response do
  subject { described_class.new(raw_response: raw_response, request: dummy_request) }

  let(:dummy_request) { RequestBuilders::Runtastic::Request.new(:get, 'http://some.url/') }

  let(:raw_response) do
    double('RawHttpResponse', code: code, return_code: return_code, return_message: return_message, body: body, success?: success?)
  end

  let(:code) { 200 }
  let(:return_code) { '' }
  let(:return_message) { '' }
  let(:body) { '{ "some_key": "some data" }' }
  let(:success?) { true }

  describe '#to_hash' do
    it 'should parse the "body" as JSON' do
      expect(subject.to_hash).to eq(some_key: 'some data')
    end
  end

  describe '#result' do
    it 'should return the "body"' do
      result = subject.result
      expect(result).to eq(body)
    end
  end

  describe 'when the response succeeds' do
    describe '#success?' do
      it 'should return true' do
        expect(subject.success?).to be_truthy
      end
    end

    describe '#fail?' do
      it 'should return false' do
        expect(subject.fail?).to be_falsey
      end
    end

    describe '#empty?' do
      it 'should return false' do
        expect(subject.empty?).to be_falsey
      end
    end

    describe 'when endpoint returns an empty response' do
      let(:body) { nil }

      describe '#empty?' do
        it 'should return true' do
          expect(subject.empty?).to be_truthy
        end
      end
    end
  end

  describe 'when the response fails' do
    let(:code) { 500 }
    let(:success?) { false }

    describe '#success?' do
      it 'should return false' do
        expect(subject.success?).to be_falsey
      end
    end

    describe '#fail?' do
      it 'should return true' do
        expect(subject.fail?).to be_truthy
      end
    end

    describe '#empty?' do
      it 'should return false' do
        expect(subject.empty?).to be_falsey
      end
    end

    describe 'when endpoint returns an empty response' do
      let(:body) { nil }

      describe '#empty?' do
        it 'should return false' do
          expect(subject.empty?).to be_truthy
        end
      end
    end
  end
end
