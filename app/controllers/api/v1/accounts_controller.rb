class Api::V1::AccountsController < ApplicationController
  before_action :set_account, only: [:show, :update, :destroy]
  before_action :authenticate
  load_and_authorize_resource
  
  # GET /accounts
  def index
#    @accounts = Account.all
#    @accounts = Account.active(params[:Active])
    @accounts = current_user.company.accounts.active(params[:Active])
      .customer(params[:CustomerID])
      .company(params[:CompanyNumber])
      .account_type(params[:ActTypeID])
      .bank_account_number(params[:BankActNbr])
      .routing_number(params[:RoutingNbr])
      .limit(accounts_limit)
    
    render json: JSON.pretty_generate(@accounts.as_json)
  end
  
  # GET /accounts/:id
  def show
    render json: JSON.pretty_generate(@account.as_json)
    rescue ActiveRecord::RecordNotFound
      head :not_found
  end
  
  # POST /accounts
  def create
    @account = Account.new(account_params)
    if @account.save
      render json: @account, status: 201
    else
      render error: {error: 'Unable to create Account.'}, status: 400
    end
  end
  
  # PUT /accounts/:id
  def update
    if @account
      @account.update(account_params)
#      render json: {message: 'Account successfully updated.'}, status: 200
      render json: @account, status: 200
    else
      render error: {error: 'Unable to update Account.'}, status: 400
    end
  end
  
  # DELETE /accounts/:id
  def destroy
    if @account
      @account.destroy
      render json: {message: 'Account successfully deleleted.'}, status: 204
    else
      render error: {error: 'Unable to delete Account.'}, status: 400
    end
  end
  
  private
  
  def accounts_limit
    (1..1000).include?(params[:limit].to_i) ?  params[:limit] : 100
  end
  
  def set_account
    @account = Account.find(params[:id])
  end
  
  def account_params
    params.require(:account).permit(:CustomerID, :CompanyNumber, :EntityID, :ActTypeID, :ActNbr, :Balance, :ButtonText, :AddIndex, :AddFlag, :AddFee, :MoveIndex, :MoveFlag,
      :MoveFee, :DepositFlag, :CreateDate, :CreateUser, :ModifiedDate, :ModifiedUser, :LockDate, :LockUser, :AddGroupID, :MoveGroupID, :AddParentID, :MoveParentID, :AuxText,
      :Active, :AbleToDelete, :IsBankAccount, :AbleToACH, :SecurityCode, :ExpDate, :IsPayeeAccount, :MinBalance, :IssuingCompanyNumber, :BankActNbr, :RoutingNbr, :SMSOnCredit,
      :SMSOnDebit, :MaintainBal, :LastACHDate)
  end
      
end