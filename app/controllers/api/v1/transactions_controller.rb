class Api::V1::TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :update, :destroy]
  
  # GET /transactions
  def index
    @transactions = Transaction.device(params[:dev_id])
    .start_time(parse_datetime(params[:start_time]))
    .end_time(parse_datetime(params[:end_time]))
    .from_customer_id(params[:FromCustID])
    .to_customer_id(params[:ToCustID])
    .from_account_id(params[:from_acct_id])
    .to_account_id(params[:to_acct_id])
    .transaction_code(params[:tran_code])
    .transaction_status(params[:tran_status])
    .secondary_transaction_code(params[:sec_tran_code])
    .error_code(params[:error_code])
    .original_transaction_id(params[:OrigTranID])
    .order("date_time DESC")
    .limit(transactions_limit)
#    render json: @transactions
    render json: JSON.pretty_generate(@transactions.as_json)
  end
  
  # GET /transactions/:id
  def show
#    render json: @transaction
    render json: JSON.pretty_generate(@transaction.as_json)
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
  
  def transactions_limit
    (1..1000).include?(params[:limit].to_i) ?  params[:limit] : 100
  end
  
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end
  
  def transaction_params
    params.require(:transaction).permit(:date_time, :dev_id, :FromCustID, :ToCustID, :tran_status, :error_code, :tran_code, :card_nbr, :receipt_nbr, :amt_req, :amt_auth, 
      :cassette_1_disp, :cassette_2_disp, :cassette_3_disp, :cassette_4_disp, :cassette_5_disp, :cassette_6_disp, :track2, :bank_id_nbr, :coin_disp, :coin_1_disp, :coin_2_disp, 
      :coin_3_disp, :coin_4_disp, :coin_5_disp, :coin_6_disp, :cashBalance, :ActID, :CreateDate, :CreateUser, :ModifiedDate, :ModifiedUser, :card_seq, :from_acct_id, :from_acct_type, 
      :to_acct_id, :to_acct_type, :authID, :sec_tran_code, :BlockID, :AddFlag, :MoveFlag, :Description, :ChpFee, :DevCompanyNbr, :IssuingCompanyNbr, :BarcodeHash, :CheckCategoryID, 
      :FeedActID, :OrigTranID, :from_acct_nbr, :to_acct_nbr, :Note, :FailedLimitID, :external_ref_nbr, :upload_file, :event_id, :dev_address, :custID, :user_id)
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