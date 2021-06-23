class Transaction < ApplicationRecord
  self.primary_key = 'tranID'
  self.table_name= 'transactions'
  
  belongs_to :device, :foreign_key => 'dev_id', optional: true
  belongs_to :company, :foreign_key => "DevCompanyNbr"
  has_one :customer_barcode
  
  scope :device, ->(dev_id) { where("dev_id = ?", dev_id) unless dev_id.blank?}
  scope :from_customer_id, ->(fromcustid) { where("FromCustID = ?", fromcustid) unless fromcustid.blank?}
  scope :to_customer_id, ->(tocustid) { where("ToCustID = ?", tocustid) unless tocustid.blank?}
  scope :from_account_id, ->(from_acct_id) { where("from_acct_id = ?", from_acct_id) unless from_acct_id.blank?}
  scope :to_account_id, ->(to_acct_id) { where("to_acct_id = ?", to_acct_id) unless to_acct_id.blank?}
  scope :transaction_status, ->(tran_status) { where("tran_status = ?", tran_status) unless tran_status.blank?}
  scope :transaction_code, ->(tran_code) { where("tran_code = ?", tran_code) unless tran_code.blank?}
  scope :secondary_transaction_code, ->(sec_tran_code) { where("sec_tran_code = ?", sec_tran_code) unless sec_tran_code.blank?}
  scope :transaction_codes, ->(tran_codes) { where("tran_code IN (?)", tran_codes) unless tran_codes.blank?}
  scope :secondary_transaction_codes, ->(sec_tran_codes) { where("sec_tran_code IN (?)", sec_tran_codes) unless sec_tran_codes.blank?}
  scope :error_code, ->(error_code) { where("error_code = ?", error_code) unless error_code.blank?}
  scope :original_transaction_id, ->(orig_tran_id) { where("OrigTranID = ?", orig_tran_id) unless orig_tran_id.blank?}
  scope :start_time, ->(start_time) { where('date_time >= ?', start_time.to_datetime) unless start_time.blank?}
  scope :end_time, ->(end_time) { where('date_time <= ?', end_time.to_datetime) unless end_time.blank?}
  
  #############################
  #     Instance Methods      #
  #############################
  
  def to_account
    Account.where(ActID: to_acct_id).first
  end
  
  def from_account
    Account.where(ActID: from_acct_id).first
  end
  
  def to_account_customers
    unless to_account.blank?
      to_account.customers
    end
  end
  
  def from_account_customers
    unless from_account.blank?
      from_account.customers
    end
  end
  
  def to_account_customers_list
    to_account_customers.map{|customer| "#{customer.full_name}"}.join(", ").html_safe
  end
  
  def from_account_customers_list
    from_account_customers.map{|customer| "#{customer.full_name}"}.join(", ").html_safe
  end
  
  def reverse
    Transaction.create(amt_req: self.amt_auth, amt_auth: self.amt_auth, tran_code: 'TFR', sec_tran_code: 'CRED', 
      Description: "Transfer from #{self.to_account_customers_list} to #{self.from_acct_id}", DevCompanyNbr: self.DevCompanyNbr, from_acct_id: self.to_acct_id, to_acct_id: self.from_acct_id, 
      receipt_nbr: self.receipt_nbr, dev_id: self.dev_id, error_code: 0, OrigTranID: self.tranID)
    to_account.update_attribute('Balance', to_account.Balance - self.amt_auth)
    from_account.update_attribute('Balance', from_account.Balance + self.amt_auth)
  end
  
  def reversal_transaction
    Transaction.where(OrigTranID: tranID, tran_code: ["TFR", "TFR "], sec_tran_code: ["CRED", "CRED "], error_code: 0).first
  end
  
  def original_transaction
    unless self.OrigTranID.blank? or self.OrigTranID.zero?
      Transaction.find(self.OrigTranID)
    else
      return nil
    end
  end
  
  def reversed?
    reversal_transaction.present?
  end
  
  def can_reverse?
    unless self.amt_auth.blank? or self.amt_auth.zero?
      unless withdrawal? or withdrawal_all?
        return true
      else
        # tran_status of 12 means the withdrawal went through successfully, so should not be able to reverse
        if tran_status == 12
          return false
        else
          # tran_status 11 means ezcash has not yet gotten a response from the ATM, so may not have dispensed anything
          if tran_status == 11
            unless reversed? # If a withdrawal has been reversed already, do not allow it to be reversed again
              return true
            end
          end
        end
      end
    end
  end
  
  def type
    unless tran_code.blank? and sec_tran_code.blank?
      if (tran_code.strip == "CHK" and sec_tran_code.strip == "TFR")
        return "Check Cashed"
      elsif (tran_code.strip == "CHKP" and sec_tran_code.strip == "TFR")
        return "Positive Check Cashed"
      elsif ((tran_code.strip == "CASH" and sec_tran_code.strip == "TFR") or (tran_code.strip == "DEP" and sec_tran_code.strip == "TFR"))
        return "Cash Deposit"
      elsif (tran_code.strip == "ACH" and sec_tran_code.strip == "TFR")
        return "ACH Deposit"
      elsif (tran_code.strip == "MON" and sec_tran_code.strip == "ORD")
        return "Money Order"
      elsif ((tran_code.strip == "WDL" or tran_code.strip == "ALL") and (sec_tran_code.blank? or sec_tran_code.strip == "TFR" or sec_tran_code.strip == "CASH"))
        return "Withdrawal"
      elsif ((tran_code.strip == "WDL" and sec_tran_code.strip == "REVT") or (tran_code.strip == "DEP" and sec_tran_code.strip == "REFD"))
        return "Reverse Withdrawal"
      elsif ((tran_code.strip == "WDL" or tran_code.strip == "ALL") and (sec_tran_code.strip == "TFR" or sec_tran_code.strip == "ALL"))
        return "Withdrawal All"
      elsif ((tran_code.strip == "CARD" or tran_code.strip == "TFR") and (sec_tran_code.strip == "TFR" or sec_tran_code.strip == "CARD"))
        return "Transfer"
      elsif (tran_code.strip == "BILL" and sec_tran_code.strip == "PAY")
        return "Bill Pay"
      elsif (tran_code.strip == "POS" and sec_tran_code.strip == "TFR")
        return "Purchase"
      elsif (tran_code.strip == "PUT" and sec_tran_code.strip == "TFR")
        return "Wire Transfer"
      elsif (tran_code.strip == "FUND" and sec_tran_code.strip == "TFR")
        return "Fund Transfer"
      elsif ((tran_code.strip == "CRED" or tran_code.strip == "TFR") and (sec_tran_code.strip == "TFR" or sec_tran_code.strip == "CRED"))
        return "Account Credit"
      elsif ((tran_code.strip == "FEE" or tran_code.strip == "TFR") and (sec_tran_code.strip == "TFR" or sec_tran_code.strip == "FEE"))
        return "Fee"
      elsif ((tran_code.strip == "FEEC" or tran_code.strip == "TFR") and (sec_tran_code.strip == "TFR" or sec_tran_code.strip == "FEEC"))
        return "Fee Credit"
      elsif (tran_code.strip == "TFR" and sec_tran_code.strip == "PMT")
        return "Balancing"
      else
        return "Unknown"
      end
    end
  end
  
  def withdrawal?
    type == "Withdrawal"
  end
  
  def withdrawal_all?
    type == "Withdrawal All"
  end
  
  #############################
  #     Class Methods         #
  #############################
end