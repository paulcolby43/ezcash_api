class Api::V1::CustomerBarcodesController < ApplicationController
  before_action :set_customer_barcode, only: [:show, :update, :destroy]
  
  # GET /customer_barcodes
  def index
#    @customer_barcodes = CustomerBarcode.all
    @customer_barcodes = CustomerBarcode.customer_id(params[:CustomerID])
    .device(params[:DevID])
    .company_number(params[:CompanyNumber])
    .barcode(params[:Barcode])
    .transaction_id(params[:TranID])
    .used(params[:Used])
    .account_id(params[:ActID])
    .start_time(parse_datetime(params[:start_time]))
    .end_time(parse_datetime(params[:end_time]))
    .limit(customer_barcodes_limit)
#    render json: @customer_barcodes
    render json: JSON.pretty_generate(JSON.parse(@customer_barcodes.to_json))
  end
  
  # GET /customer_barcodes/:id
  def show
#    render json: @customer_barcode
    render json: JSON.pretty_generate(JSON.parse(@customer_barcode.to_json))
    rescue ActiveRecord::RecordNotFound
      head :not_found
  end
  
  # POST /customer_barcodes
  def create
    @customer_barcode = CustomerBarcode.new(customer_barcode_params)
    if @customer_barcode.save
      render json: @customer_barcode, status: 201
    else
      render error: {error: 'Unable to create CustomerBarcode.'}, status: 400
    end
  end
  
  # PUT /customer_barcodes/:id
  def update
    if @customer_barcode
      @customer_barcode.update(customer_barcode_params)
#      render json: {message: 'CustomerBarcode successfully updated.'}, status: 200
      render json: @customer_barcode, status: 200
    else
      render error: {error: 'Unable to update CustomerBarcode.'}, status: 400
    end
  end
  
  # DELETE /customer_barcodes/:id
  def destroy
    if @customer_barcode
      @customer_barcode.destroy
      render json: {message: 'CustomerBarcode successfully deleleted.'}, status: 204
    else
      render error: {error: 'Unable to delete CustomerBarcode.'}, status: 400
    end
  end
  
  private
  
  def set_customer_barcode
    @customer_barcode = CustomerBarcode.find(params[:id])
  end
  
  def customer_barcode_params
    params.require(:customer_barcode).permit()
  end
  
  def customer_barcodes_limit
    (1..100).include?(params[:limit].to_i) ?  params[:limit] : 10
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