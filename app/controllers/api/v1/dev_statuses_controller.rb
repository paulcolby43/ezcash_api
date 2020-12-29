class Api::V1::DevStatusesController < ApplicationController
  before_action :set_dev_status, only: [:show, :update, :destroy]
  before_action :authenticate
  load_and_authorize_resource
  
  # GET /dev_statuses
  def index
#    @dev_statuses = DevStatus.device(params[:dev_id])
    @dev_statuses = current_user.company.dev_statuses.device(params[:dev_id])
    .device(params[:device_id])
    .status(params[:status])
    .start_time(parse_datetime(params[:start_time]))
    .end_time(parse_datetime(params[:end_time]))
    .order("date_time DESC")
    .limit(dev_statuses_limit)
    render json: JSON.pretty_generate(@dev_statuses.as_json)
  end
  
  # GET /dev_statuses/:id
  def show
#    render json: @dev_status
    render json: JSON.pretty_generate(@dev_status.as_json)
    rescue ActiveRecord::RecordNotFound
      head :not_found
  end
  
  # POST /dev_statuses
  def create
    @dev_status = DevStatus.new(dev_status_params)
    if @dev_status.save
      render json: @dev_status, status: 201
    else
      render error: {error: 'Unable to create DevStatus.'}, status: 400
    end
  end
  
  # PUT /dev_statuses/:id
  def update
    if @dev_status
      @dev_status.update(dev_status_params)
#      render json: {message: 'DevStatus successfully updated.'}, status: 200
      render json: @dev_status, status: 200
    else
      render error: {error: 'Unable to update DevStatus.'}, status: 400
    end
  end
  
  # DELETE /dev_statuses/:id
  def destroy
    if @dev_status
      @dev_status.destroy
      render json: {message: 'DevStatus successfully deleleted.'}, status: 204
    else
      render error: {error: 'Unable to delete DevStatus.'}, status: 400
    end
  end
  
  private
  
  def set_dev_status
#    @dev_status = DevStatus.find(params[:id])
    @dev_status = DevStatus.find([params[:id], params[:dev_id]])
  end
  
  def dev_statuses_limit
    (1..1000).include?(params[:limit].to_i) ?  params[:limit] : 100
  end
  
  def parse_datetime(datetime)
    unless datetime.blank?
      begin
#         Time.parse(datetime)
         datetime.to_datetime
      rescue ArgumentError
         nil
      end
    else
      nil
    end
  end
  
  def dev_status_params
    params.require(:dev_status).permit(:dev_id, :date_time, :status, :raw_status)
  end
      
end