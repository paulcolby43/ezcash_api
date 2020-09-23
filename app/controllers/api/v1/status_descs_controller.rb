class Api::V1::StatusDescsController < ApplicationController
  before_action :set_status_desc, only: [:show, :update, :destroy]
  
  # GET /status_descs
  def index
#    @status_descs = StatusDesc.all
    @status_descs = StatusDesc.status(params[:status])
      .short_description(params[:short_desc])
      .caution_flag(params[:caution_flag])
      .alert_flag(params[:alert_flag])
    render json: JSON.pretty_generate(@status_descs.as_json)
  end
  
  # GET /status_descs/:id
  def show
#    render json: @status_desc
    render json: JSON.pretty_generate(@status_desc.as_json)
    rescue ActiveRecord::RecordNotFound
      head :not_found
  end
  
  # POST /status_descs
  def create
    @status_desc = StatusDesc.new(status_desc_params)
    if @status_desc.save
      render json: @status_desc, status: 201
    else
      render error: {error: 'Unable to create StatusDesc.'}, status: 400
    end
  end
  
  # PUT /status_descs/:id
  def update
    if @status_desc
      @status_desc.update(status_desc_params)
#      render json: {message: 'StatusDesc successfully updated.'}, status: 200
      render json: @status_desc, status: 200
    else
      render error: {error: 'Unable to update StatusDesc.'}, status: 400
    end
  end
  
  # DELETE /status_descs/:id
  def destroy
    if @status_desc
      @status_desc.destroy
      render json: {message: 'StatusDesc successfully deleleted.'}, status: 204
    else
      render error: {error: 'Unable to delete StatusDesc.'}, status: 400
    end
  end
  
  private
  
  def set_status_desc
    @status_desc = StatusDesc.find(params[:id])
  end
  
  def status_desc_params
    params.require(:status_desc).permit(:status, :short_desc, :caution_flag, :alert_flag)
  end
  
end