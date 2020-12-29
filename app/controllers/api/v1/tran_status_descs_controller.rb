class Api::V1::TranStatusDescsController < ApplicationController
  before_action :set_tran_status_desc, only: [:show, :update, :destroy]
  before_action :authenticate
  load_and_authorize_resource
  
  # GET /tran_status_descs
  def index
#    @tran_status_descs = TranStatusDesc.all
    @tran_status_descs = TranStatusDesc.tran_status(params[:tran_status])
      .short_description(params[:short_desc])
      .long_description(params[:long_desc])
    render json: JSON.pretty_generate(@tran_status_descs.as_json)
  end
  
  # GET /tran_status_descs/:id
  def show
#    render json: @tran_status_desc
    render json: JSON.pretty_generate(@tran_status_desc.as_json)
    rescue ActiveRecord::RecordNotFound
      head :not_found
  end
  
  # POST /tran_status_descs
  def create
    @tran_status_desc = TranStatusDesc.new(tran_status_desc_params)
    if @tran_status_desc.save
      render json: @tran_status_desc, status: 201
    else
      render error: {error: 'Unable to create TranStatusDesc.'}, status: 400
    end
  end
  
  # PUT /tran_status_descs/:id
  def update
    if @tran_status_desc
      @tran_status_desc.update(tran_status_desc_params)
#      render json: {message: 'TranStatusDesc successfully updated.'}, status: 200
      render json: @tran_status_desc, status: 200
    else
      render error: {error: 'Unable to update TranStatusDesc.'}, status: 400
    end
  end
  
  # DELETE /tran_status_descs/:id
  def destroy
    if @tran_status_desc
      @tran_status_desc.destroy
      render json: {message: 'TranStatusDesc successfully deleleted.'}, status: 204
    else
      render error: {error: 'Unable to delete TranStatusDesc.'}, status: 400
    end
  end
  
  private
  
  def set_tran_status_desc
    @tran_status_desc = TranStatusDesc.find(params[:id])
  end
  
  def tran_status_desc_params
    params.require(:tran_status_desc).permit(:tran_status, :short_desc, :long_desc)
  end
  
end