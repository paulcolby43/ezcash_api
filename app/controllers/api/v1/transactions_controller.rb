class Api::V1::TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :update, :destroy]
  
  # GET /transactions
  def index
    @transactions = Transaction.all
    @transactions = Transaction.device(params[:dev_id])
    .start_time(parse_datetime(params[:start_time]))
    .end_time(parse_datetime(params[:end_time]))
    .from_customer_id(params[:FromCustID])
#    render json: @transactions
    render json: JSON.pretty_generate(JSON.parse(@transactions.to_json))
  end
  
  # GET /transactions/:id
  def show
#    render json: @transaction
    render json: JSON.pretty_generate(JSON.parse(@transaction.to_json))
    rescue ActiveRecord::RecordNotFound
      head :not_found
  end
  
  # POST /transactions
  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
      render json: @transaction, status: 201
    else
      render error: {error: 'Unable to create Transaction.'}, status: 400
    end
  end
  
  # PUT /transactions/:id
  def update
    if @transaction
      @transaction.update(transaction_params)
#      render json: {message: 'Transaction successfully updated.'}, status: 200
      render json: @transaction, status: 200
    else
      render error: {error: 'Unable to update Transaction.'}, status: 400
    end
  end
  
  # DELETE /transactions/:id
  def destroy
    if @transaction
      @transaction.destroy
      render json: {message: 'Transaction successfully deleleted.'}, status: 204
    else
      render error: {error: 'Unable to delete Transaction.'}, status: 400
    end
  end
  
  private
  
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end
  
  def transaction_params
    params.require(:transaction).permit()
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