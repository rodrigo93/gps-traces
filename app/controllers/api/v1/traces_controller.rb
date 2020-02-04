class Api::V1::TracesController < ApplicationController
  before_action :set_trace, only: %i[show update destroy]

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

  # Use callbacks to share common setup or constraints between actions.
  def set_trace
    @trace = Trace.find(params[:id])
  end
end
