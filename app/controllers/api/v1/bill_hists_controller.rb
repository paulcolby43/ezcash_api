class Api::V1::BillHistsController < ApplicationController
  before_action :set_bill_hist, only: [:show, :update, :destroy]
  
  # GET /bill_hists
  def index
#    @bill_hists = BillHist.all
    @bill_hists = BillHist.denomination(params[:denomination])
    .start_time(parse_datetime(params[:start_time]))
    .end_time(parse_datetime(params[:end_time]))
    .device(params[:dev_id])
    .device(params[:device_id])
    .cassette_id(params[:cassette_id])
    .user_name(params[:user_name])
    .cut_date(params[:cut_dt])
    .order("cut_dt DESC")
    .limit(bill_hists_limit)
#    render json: @bill_hists
    render json: JSON.pretty_generate(@bill_hists.as_json)
  end
  
  # GET /bill_hists/:id
  def show
#    render json: @bill_hist
    render json: JSON.pretty_generate(@bill_hist.as_json)
    rescue ActiveRecord::RecordNotFound
      head :not_found
  end
  
  # POST /bill_hists
  def create
    @bill_hist = BillHist.new(bill_hist_params)
    if @bill_hist.save
      render json: @bill_hist, status: 201
    else
      render error: {error: 'Unable to create BillHist.'}, status: 400
    end
  end
  
  # PUT /bill_hists/:id
  def update
    if @bill_hist
      @bill_hist.update(bill_hist_params)
#      render json: {message: 'BillHist successfully updated.'}, status: 200
      render json: @bill_hist, status: 200
    else
      render error: {error: 'Unable to update BillHist.'}, status: 400
    end
  end
  
  # DELETE /bill_hists/:id
  def destroy
    if @bill_hist
      @bill_hist.destroy
      render json: {message: 'BillHist successfully deleleted.'}, status: 204
    else
      render error: {error: 'Unable to delete BillHist.'}, status: 400
    end
  end
  
  private
  
  def bill_hists_limit
    (1..100).include?(params[:limit].to_i) ?  params[:limit] : 100
  end
  
  def set_bill_hist
#    @bill_hist = BillHist.find(params[:id])
#    @bill_hist = BillHist.find_by(dev_id: params[:dev_id], cassette_id: params[:id])
    @bill_hist = BillHist.find([params[:id], params[:dev_id]])
  end
  
  def bill_hist_params
    params.require(:bill_hist).permit(:cut_dt, :old_start, :old_term_cyc, :old_host_cyc, :added, :replaced, :new_start, :cassette_id, :dev_id, :old_added, :user_name, :denomination)
  end
  
  def parse_datetime(datetime)
    unless datetime.blank?
      begin
         Time.parse(datetime)
      rescue ArgumentError
         nil
      end
    else
      nil
    end
  end
  
end