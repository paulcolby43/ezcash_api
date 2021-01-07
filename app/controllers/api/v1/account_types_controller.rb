class Api::V1::AccountTypesController < ApplicationController
  before_action :set_account_type, only: [:show, :update, :destroy]
  before_action :authenticate
  load_and_authorize_resource
  
  # GET /account_types
  def index
    @account_types = AccountType.all
    @account_types = current_user.company.account_types
#    @account_types = AccountType.active(params[:Active])
#      .customer(params[:CustomerID])
#      .company(params[:CompanyNumber])
#      .account_type_type(params[:ActTypeID])
#      .bank_account_type_number(params[:BankActNbr])
#      .routing_number(params[:RoutingNbr])
#      .limit(account_types_limit)
    
    render json: JSON.pretty_generate(@account_types.as_json)
  end
  
  # GET /account_types/:id
  def show
    render json: JSON.pretty_generate(@account_type.as_json)
    rescue ActiveRecord::RecordNotFound
      head :not_found
  end
  
  # POST /account_types
  def create
    @account_type = AccountType.new(account_type_params)
    if @account_type.CompanyNumber == current_user.company_id and @account_type.save
      render json: @account_type, status: 201
    else
      render error: {error: 'Unable to create AccountType.'}, status: 400
    end
  end
  
  # PUT /account_types/:id
  def update
    if @account_type
      @account_type.update(account_type_params)
#      render json: {message: 'AccountType successfully updated.'}, status: 200
      render json: @account_type, status: 200
    else
      render error: {error: 'Unable to update AccountType.'}, status: 400
    end
  end
  
  # DELETE /account_types/:id
  def destroy
    if @account_type
      @account_type.destroy
      render json: {message: 'AccountType successfully deleleted.'}, status: 204
    else
      render error: {error: 'Unable to delete AccountType.'}, status: 400
    end
  end
  
  private
  
  def account_types_limit
    (1..1000).include?(params[:limit].to_i) ?  params[:limit] : 100
  end
  
  def set_account_type
    @account_type = AccountType.find(params[:id])
  end
  
  def account_type_params
    params.require(:account_type).permit(:AccountTypeDesc, :LockDate, :LockUser, :AddFlag, :MoveFlag, :DepositFlag, :AddPriTranCode, :AddTranDesc, :AddTranIcon, :MovePriTranCode,
      :MoveTranDesc, :MoveTranIcon, :AddBalEff, :AddFeeEff, :MoveBalEff, :MoveFeeEff, :AddSecTranCode, :MoveSecTranCode, :DescLangObjID, :AuxTextObjID, :CompanyNumber, :CanFundByACH, 
      :CanFundByCC, :CanFundByCash, :CanWithdraw, :CanPull, :CanRequestPmtBySearch, :CanRequestPmtByScan, :CurrencyType, :CanSendPmt, :WithdrawAll, :CanBePulledBySearch, :CanBePulledByScan, 
      :MinMaintainBal, :MinBalPercent, :MinBalMax, :DefaultMinBal, :CanBePushedByScan, :contract_id, :date_of_birth_required, :social_security_number_required, :clear_balances_bill_externally,
      :hide_pull_payment_from_holder, :bill_code, :CorpAcctFlag, :single_withdrawal_limit, :daily_withdrawal_limit, :single_transfer_limit, :daily_transfer_limit)
  end
      
end