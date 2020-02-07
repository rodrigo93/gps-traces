require 'rails_helper'

RSpec.describe Api::V1::TracesController, type: :controller do
  shared_context 'returning json content-type' do
    it 'should return a request with header Content-Type: "application/json"' do
      subject

      expect(response.media_type).to eq('application/json')
    end
  end

  shared_context 'returning not found status' do
    it 'should return status 404 (not found)' do
      subject

      expect(response).to have_http_status(:not_found)
    end
  end

  shared_context 'returning created status' do
    it 'should return status 201 (created)' do
      subject

      expect(response).to have_http_status(:created)
    end
  end

  shared_context 'returning ok status' do
    it 'should return status 200 (ok)' do
      subject

      expect(response).to have_http_status(:ok)
    end
  end

  shared_context 'returning a unprocessable entity request' do
    it 'should return error 422 (unprocessable entity)' do
      subject

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  shared_context 'having a malformed JSON or coordinates' do
    it 'should return error 400 (bad request)' do
      subject

      expect(JSON.parse(response.body)['coordinates']).to include("The JSON must be well formatted and all latitudes and longitudes must be present")
    end
  end

  shared_context 'updating trace' do
    it 'should update the Trace' do
      old_update_at = trace.updated_at

      subject

      expect(trace.reload.updated_at).to be > old_update_at
    end
  end

  shared_context 'not creating a new Trace' do
    it 'should not create a new Trace' do
      expect { subject }.to change { Trace.count }.by(0)
    end
  end

  describe '#POST create' do
    subject { post :create, params: params }

    context 'when everything is ok' do
      let(:coordinates_params) { [{"latitude": 32.937931060791, "longitude": -117.229949951172},
                                  {"latitude": 32.9379615783691, "longitude": -117.229919433594}] }
      let(:params) { {coordinates: coordinates_params.to_json} }

      it_should_behave_like 'returning json content-type'

      it_should_behave_like 'returning created status'

      it 'should create a new Trace' do
        expect { subject }.to change { Trace.count }.by(1)
      end
    end

    context 'when validating "coordinates"' do
      context "and it's not present" do
        let(:params) { {} }

        it_should_behave_like 'returning json content-type'

        it_should_behave_like 'returning a unprocessable entity request'

        it_should_behave_like 'having a malformed JSON or coordinates'
      end

      context 'and there is no latitude' do
        let(:params) { {coordinates: [{"longitude": -73.9483489990234}]} }

        it_should_behave_like 'returning json content-type'

        it_should_behave_like 'returning a unprocessable entity request'

        it_should_behave_like 'having a malformed JSON or coordinates'
      end

      context 'and there is no longitude' do
        let(:params) { {coordinates: [{"latitude": -73.9483489990234}]} }

        it_should_behave_like 'returning json content-type'

        it_should_behave_like 'returning a unprocessable entity request'

        it_should_behave_like 'having a malformed JSON or coordinates'
      end
    end
  end

  describe '#PUT update' do
    subject { put :update, params: params }

    let(:dummy_coordinates) { [{"latitude": 32.937931060791, "longitude": -117.229949951172}] }
    let!(:trace) { Trace.create(coordinates: dummy_coordinates.to_json) }

    context 'when everything is ok' do
      let(:coordinates_params) { [{"latitude": 32.937931060791, "longitude": -117.229949951172},
                                  {"latitude": 32.9379615783691, "longitude": -117.229919433594}] }
      let(:params) do
        {
            id: trace.id,
            coordinates: coordinates_params.to_json
        }
      end

      it_should_behave_like 'returning json content-type'

      it_should_behave_like 'returning ok status'

      it_should_behave_like 'not creating a new Trace'

      it_should_behave_like 'updating trace'
    end

    context 'when validating "coordinates"' do
      context "and it's not present" do
        let(:params) {{id: trace.id}}

        it_should_behave_like 'returning json content-type'

        it_should_behave_like 'returning a unprocessable entity request'

        it_should_behave_like 'having a malformed JSON or coordinates'
      end

      context 'and there is no latitude' do
        let(:coordinates_params) { [{"longitude": -117.229949951172}, {"longitude": -117.229919433594}] }
        let(:params) do
          {
              id: trace.id,
              coordinates: coordinates_params.to_json
          }
        end

        it_should_behave_like 'returning json content-type'

        it_should_behave_like 'returning a unprocessable entity request'

        it_should_behave_like 'having a malformed JSON or coordinates'
      end

      context 'and there is no longitude' do
        let(:coordinates_params) { [{"latitude": 32.937931060791}, {"latitude": 32.9379615783691}] }

        let(:params) do
          {
              id: trace.id,
              coordinates: coordinates_params.to_json
          }
        end

        it_should_behave_like 'returning json content-type'

        it_should_behave_like 'returning a unprocessable entity request'

        it_should_behave_like 'having a malformed JSON or coordinates'
      end
    end
  end

  describe '#PATCH update' do
    subject { patch :update, params: params }

    let(:dummy_coordinates) { [{"latitude": 32.937931060791, "longitude": -117.229949951172}] }
    let!(:trace) { Trace.create(coordinates: dummy_coordinates.to_json) }

    context 'when everything is ok' do
      let(:coordinates_params) { [{"latitude": 32.937931060791, "longitude": -117.229949951172},
                                  {"latitude": 32.9379615783691, "longitude": -117.229919433594}] }
      let(:params) do
        {
            id: trace.id,
            coordinates: coordinates_params.to_json
        }
      end

      it_should_behave_like 'returning json content-type'

      it_should_behave_like 'returning ok status'

      it_should_behave_like 'updating trace'

      it_should_behave_like 'not creating a new Trace'
    end

    context 'when validating "coordinates"' do
      context "and it's not present" do
        let(:params) {{id: trace.id}}

        it_should_behave_like 'returning json content-type'

        it_should_behave_like 'returning a unprocessable entity request'

        it_should_behave_like 'having a malformed JSON or coordinates'
      end

      context 'and there is no latitude' do
        let(:coordinates_params) { [{"longitude": -117.229949951172}, {"longitude": -117.229919433594}] }
        let(:params) do
          {
              id: trace.id,
              coordinates: coordinates_params.to_json
          }
        end

        it_should_behave_like 'returning json content-type'

        it_should_behave_like 'returning a unprocessable entity request'

        it_should_behave_like 'having a malformed JSON or coordinates'
      end

      context 'and there is no longitude' do
        let(:coordinates_params) { [{"latitude": 32.937931060791}, {"latitude": 32.9379615783691}] }

        let(:params) do
          {
              id: trace.id,
              coordinates: coordinates_params.to_json
          }
        end

        it_should_behave_like 'returning json content-type'

        it_should_behave_like 'returning a unprocessable entity request'

        it_should_behave_like 'having a malformed JSON or coordinates'
      end
    end
  end

  describe '#GET show' do
    subject { get :show, params: {id: trace_id} }

    context 'when the Trace exists' do
      let!(:trace) { Trace.create!(coordinates: [{"latitude":40.780517578125,"longitude":-73.9483489990234}].to_json) }
      let(:trace_id) { trace.id }

      it_should_behave_like 'returning json content-type'

      it 'should return status 302 (found)' do
        subject

        expect(response).to have_http_status(:found)
      end
    end

    context 'when the Trace does not exist' do
      let(:trace_id) { 12345 }

      it_should_behave_like 'returning json content-type'

      it_should_behave_like 'returning not found status'

      it 'should return a proper error message' do
        subject

        expect(JSON.parse(response.body)['error']).to eq "Trace cannot be found"
      end
    end
  end

  describe '#DELETE destroy' do
    subject { delete :destroy, params: {id: trace_id} }

    context 'when the Trace exists' do
      let!(:trace) { Trace.create!(coordinates: [{"latitude":40.780517578125,"longitude":-73.9483489990234}].to_json) }
      let(:trace_id) { trace.id }

      it 'should return status 204 (no content)' do
        subject

        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when the Trace does not exist' do
      let(:trace_id) { 12345 }

      it_should_behave_like 'returning json content-type'

      it_should_behave_like 'returning not found status'

      it 'should return a proper error message' do
        subject

        expect(JSON.parse(response.body)['error']).to eq "Trace cannot be found"
      end
    end
  end
end
