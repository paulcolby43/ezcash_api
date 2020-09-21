class Api::V1::BillCountsController < ApplicationController
  before_action :set_bill_count, only: [:show, :update, :destroy]
  
  # GET /bill_counts
  def index
#    @bill_counts = BillCount.all
    @bill_counts = BillCount.device(params[:dev_id])
    .device(params[:device_id])
    .cassette_nbr(params[:cassette_nbr])
    .cassette_id(params[:cassette_id])
    .status(params[:status])
    .limit(bill_counts_limit)
#    render json: @bill_counts
#    render json: JSON.pretty_generate(JSON.parse(@bill_counts.to_json))
    render json: JSON.pretty_generate(@bill_counts.as_json)
  end
  
  # GET /bill_counts/:id
  def show
#    render json: @bill_count
#    render json: JSON.pretty_generate(JSON.parse(@bill_count.to_json))
    render json: JSON.pretty_generate(@bill_count.as_json)
    rescue ActiveRecord::RecordNotFound
      head :not_found
  end
  
  # POST /bill_counts
  def create
    @bill_count = BillCount.new(bill_count_params)
    if @bill_count.save
      render json: @bill_count, status: 201
    else
      render error: {error: 'Unable to create BillCount.'}, status: 400
    end
  end
  
  # PUT /bill_counts/:id
  def update
    if @bill_count
      @bill_count.update(bill_count_params)
#      render json: {message: 'BillCount successfully updated.'}, status: 200
      render json: @bill_count, status: 200
    else
      render error: {error: 'Unable to update BillCount.'}, status: 400
    end
  end
  
  # DELETE /bill_counts/:id
  def destroy
    if @bill_count
      @bill_count.destroy
      render json: {message: 'BillCount successfully deleleted.'}, status: 204
    else
      render error: {error: 'Unable to delete BillCount.'}, status: 400
    end
  end
  
  private
  
  def bill_counts_limit
    (1..100).include?(params[:limit].to_i) ?  params[:limit] : 10
  end
  
  def set_bill_count
    @bill_count = BillCount.find_by(dev_id: params[:device_id], cassette_nbr: params[:id])
  end
  
  def bill_count_params
    params.require(:bill_count).permit(:host_start_count, :host_cycle_count, :dev_start_count, :dev_cycle_count, :dev_divert_count, :added_count, :old_added, :status)
  end
      
end