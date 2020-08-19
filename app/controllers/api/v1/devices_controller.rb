class Api::V1::DevicesController < ApplicationController
  before_action :set_device, only: [:show, :update, :destroy]
  
  # GET /devices
  def index
    @devices = Device.all
#    @devices = Device.device_name(params[:device_name])
#    .device_name(params[:device_name])
#    .yard_id(params[:yardid])
#    render json: @devices
    render json: JSON.pretty_generate(JSON.parse(@devices.to_json))
  end
  
  # GET /devices/:id
  def show
#    render json: @device
    render json: JSON.pretty_generate(JSON.parse(@device.to_json))
    rescue ActiveRecord::RecordNotFound
      head :not_found
  end
  
  # POST /devices
  def create
    @device = Device.new(device_params)
    if @device.save
      render json: @device, status: 201
    else
      render error: {error: 'Unable to create Device.'}, status: 400
    end
  end
  
  # PUT /devices/:id
  def update
    if @device
      @device.update(device_params)
#      render json: {message: 'Device successfully updated.'}, status: 200
      render json: @device, status: 200
    else
      render error: {error: 'Unable to update Device.'}, status: 400
    end
  end
  
  # DELETE /devices/:id
  def destroy
    if @device
      @device.destroy
      render json: {message: 'Device successfully deleleted.'}, status: 204
    else
      render error: {error: 'Unable to delete Device.'}, status: 400
    end
  end
  
  private
  
  def set_device
    @device = Device.find(params[:id])
  end
  
  def device_params
    params.require(:device).permit()
  end
      
end