module Api
  module V1
    class TracesController < ApplicationController
      before_action :fetch_trace, only: %i[show]
      before_action :set_trace, only: %i[update destroy]

      rescue_from ActiveRecord::RecordNotFound do
        render json: {error: 'Trace cannot be found'}, status: :not_found
      end

      # GET /api/v1/traces/1
      def show
        render json: @trace, status: :found
      end

      # POST /api/v1/traces
      def create
        @trace = Trace.new(coordinates: params[:coordinates])
        if @trace.save
          render json: @trace, status: :created
        else
          render json: @trace.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/traces/1
      def update
        if @trace.update(coordinates: params[:coordinates])
          render json: @trace
        else
          render json: @trace.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/traces/1
      def destroy
        @trace.destroy
      end

      private

      def fetch_trace
        id = params[:id]
        redis_trace_key = "trace_#{id}"
        @trace = $redis.get(redis_trace_key)

        unless @trace.present?
          @trace = Trace.find(id)
          @trace.update_distances! unless @trace.distances_calculated?

          $redis.set(redis_trace_key, @trace.to_json)
        end
      end

      def set_trace
        @trace = Trace.find(params[:id])
      end
    end
  end
end
