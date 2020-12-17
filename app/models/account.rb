class Account < ApplicationRecord
  self.primary_key = 'ActID'
  self.table_name= 'Accounts'
  
  belongs_to :company, :foreign_key => 'CompanyNumber'
  
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
  
  def authorize_amount_json(amount)
#    available_balance > amount
    if available_balance > amount
      unless amount.zero?
        amount = amount
      else
        amount = available_balance
      end
      return {"authorized" => true, "amount" => amount}
    else
      return {"authorized" => false, "amount" => 0, "message" => "Allowed amount is less than requested amount."}
    end
    
  end
  
  #############################
  #     Class Methods         #
  #############################
end