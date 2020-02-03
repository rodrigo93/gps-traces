class Api::V1::TracesController < ApplicationController
  before_action :set_trace, only: %i[show update destroy]

  # GET /api/v1/traces
  def index
    @traces = Trace.all

    render json: @traces
  end

  # GET /api/v1/traces/1
  def show
    render json: @trace
  end

  # POST /api/v1/traces
  def create
    @trace = Trace.new(trace_params.merge(user: current_user))
    if @trace.save
      render json: @trace, status: :created
    else
      render json: @trace.errors, status: :unprocessable_entity
    end

  end

  # PATCH/PUT /api/v1/traces/1
  def update
    if @trace.update(trace_params)
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

  # Only allow a trusted parameter "white list" through.
  def trace_params
    params.require(:trace).permit(:coordinates)
  end
end
