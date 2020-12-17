class Account < ApplicationRecord
  self.primary_key = 'ActID'
  self.table_name= 'Accounts'
  
  belongs_to :company, :foreign_key => 'CompanyNumber'
  belongs_to :account_type, :foreign_key => 'ActTypeID'
  
  scope :active, ->(active) { where("Active = ?", active) unless active.blank?}
  scope :customer, ->(customer_id) { where("CustomerID = ?", customer_id) unless customer_id.blank?}
  scope :company, ->(company_id) { where("CompanyNumber = ?", company_id) unless company_id.blank?}
  scope :account_type, ->(account_type_id) { where("ActTypeID = ?", account_type_id) unless account_type_id.blank?}
  scope :bank_account_number, ->(bank_account_number) { where("BankActNbr = ?", bank_account_number) unless bank_account_number.blank?}
  scope :routing_number, ->(routing_number) { where("RoutingNbr = ?", routing_number) unless routing_number.blank?}
  
  #############################
  #     Instance Methods      #
  #############################
  
  def balance
    self.Balance
  end
  
  def available_balance
    # If the account minimum balance is nil, set to zero
    unless self.MinBalance.blank? or self.MinBalance.zero?
      if self.MinBalance < 0 and self.Balance < 0
        account_balance = (self.MinBalance - self.Balance).abs
      else
        account_balance = self.Balance - self.MinBalance
      end
    else
      account_balance = self.Balance
    end
    if account_balance < 0
      return 0
    else
      return account_balance
    end
  end
  
  def minimum_balance
    unless self.MinBalance.blank?
      self.MinBalance.abs
    else
      0
    end
  end
  
  # Withdraw a specific amount
  def withdrawal_transactions
    transactions = Transaction.where(from_acct_id: id, tran_code: 'WDL') + Transaction.where(to_acct_id: id, tran_code: 'WDL')
    return transactions
  end
  
  # Withdraw all available balance
  def withdrawal_all_transactions
    transactions = Transaction.where(from_acct_id: id, tran_code: 'ALL').order("date_time DESC") + Transaction.where(to_acct_id: id, tran_code: 'ALL').order("date_time DESC")
    return transactions
  end
  
  def withdrawal_reversals
    transactions = Transaction.where(to_acct_id: id, tran_code: ['DEP', 'DEP '], sec_tran_code: ['REFD', 'REFD '])
    return transactions
  end
  
  def withdrawals
    withdrawal_transactions + withdrawal_all_transactions
  end
  
  def single_withdrawal_limit
    account_type.single_withdrawal_limit unless account_type.blank?
  end
  
  def daily_withdrawal_limit
    account_type.daily_withdrawal_limit unless account_type.blank?
  end
  
  def account_type_withdrawals_total_amount_today
    unless account_type.blank?
      account_type.withdrawals_total_amount_today 
    else
      0
    end
  end
  
  def authorize_withdrawal_amount_json(amount)
#    available_balance > amount
    available_balance_amount = available_balance
    single_withdrawal_limit_amount = single_withdrawal_limit
    daily_withdrawal_limit_amount = daily_withdrawal_limit
    requested_amount = amount.zero? ? available_balance_amount : amount
    if requested_amount <= available_balance_amount
      unless single_withdrawal_limit_amount.blank?
        if requested_amount <= single_withdrawal_limit_amount
          unless daily_withdrawal_limit_amount.blank?
            if requested_amount + account_type_withdrawals_total_amount_today <= daily_withdrawal_limit_amount
              response = {"authorized" => true, "amount" => requested_amount}
            else
              response = {"authorized" => false, "amount" => 0, "message" => "Daily Withdrawal Limit exceeded."}
            end
          else
            response = {"authorized" => true, "amount" => requested_amount}
          end
        else
          response = {"authorized" => false, "amount" => 0, "message" => "Single Withdrawal Limit exceeded."}
        end
      else
        unless daily_withdrawal_limit_amount.blank?
          if requested_amount + account_type_withdrawals_total_amount_today <= daily_withdrawal_limit_amount
            response = {"authorized" => true, "amount" => requested_amount}
          else
            response = {"authorized" => false, "amount" => 0, "message" => "Daily Withdrawal Limit exceeded."}
          end
        else
          response = {"authorized" => true, "amount" => requested_amount}
        end
      end
    else
      response = {"authorized" => false, "amount" => 0, "message" => "Available balance is less than requested amount."}
    end
    return response.merge({'available_balance' => available_balance_amount, 'single_withdrawal_limit' => single_withdrawal_limit_amount, 'daily_withdrawal_limit' => daily_withdrawal_limit_amount, 'requested_amount' => amount})
    
  end
  
  #############################
  #     Class Methods         #
  #############################
end