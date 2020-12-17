class AccountType < ApplicationRecord
  self.primary_key = 'AccountTypeID'
  self.table_name= 'AccountTypes'
  
  has_many :accounts, :foreign_key => "ActTypeID"
  belongs_to :company, :foreign_key => "CompanyNumber"
  
  #############################
  #     Instance Methods      #
  #############################
  
  def description
    self.AccountTypeDesc
  end
  
  def can_fund_by_ach?
    self.CanFundByACH == 1
  end
  
  def can_fund_by_cc?
    self.CanFundByCC == 1
  end
  
  def can_fund_by_cash?
    self.CanFundByCash == 1
  end
  
  def can_withdraw?
    self.CanWithdraw == 1
  end
  
  def withdrawal_all?
    self.WithdrawAll == 1
  end
  
  def can_pull?
    self.CanPull == 1
  end
  
  def can_request_payment_by_search?
    self.CanRequestPmtBySearch == 1
  end
  
  def can_request_payment_by_scan?
    self.CanRequestPmtByScan == 1
  end
  
  def can_send_payment?
    self.CanSendPmt == 1
  end
  
  def can_be_pulled_by_search?
    self.CanBePulledBySearch == 1
  end
  
  def can_be_pulled_by_scan?
    self.CanBePulledByScan == 1
  end
  
  def can_be_pushed_by_scan?
    self.CanBePushedByScan == 1
  end
  
  def hide_pull_payment_from_holder?
    self.hide_pull_payment_from_holder == 1
  end
  
  def heavy_metal_debit?
    self.AccountTypeID == 6
  end
  
  def company_account?
    self.AccountTypeID == 7
  end
  
  def clear_balances_and_bill_externally?
    self.clear_balances_bill_externally == 1
  end
  
  def corporate_account?
    self.CorpAcctFlag == true or self.CorpAcctFlag == 1
  end
  
  def default_minimum_balance
    unless self.DefaultMinBal.blank?
      self.DefaultMinBal
    else
      0
    end
  end
  
  def accounts_cash_total
    sum = 0
    accounts.with_balance.each do |account|
      sum = sum + account.balance unless account == account.company.transaction_account
    end
    return sum
  end
  
  def withdrawals_total_amount_today
    total = 0
    Transaction.where(date_time: Date.today.beginning_of_day..Date.today.end_of_day, tran_code: ["WDL", "WDL "]).each do |transaction|
      if accounts.include?(transaction.from_account)
        total = total + transaction.amt_auth
      end 
    end
    return total
  end
  
  #############################
  #     Class Methods      #
  #############################
  
end