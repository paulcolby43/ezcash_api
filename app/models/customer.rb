class Customer < ApplicationRecord
  self.primary_key = 'CustomerID'
  self.table_name= 'Customer'
  
  scope :company, ->(company_id) { where("CompanyNumber = ?", company_id) unless company_id.blank?}
  
  belongs_to :company, :foreign_key => 'CompanyNumber'
  has_many :customer_cards, :foreign_key => "CustomerID", autosave: true, dependent: :destroy
  has_many :accounts, through: :customer_cards
  
  
  #############################
  #     Instance Methods      #
  #############################
  
  def full_name
    unless self.NameF.blank? and self.NameL.blank? and self.NameS.blank?
      "#{self.NameF} #{self.NameL}"
    else
      unless self.phone.blank?
        self.phone
      else
        "Anonymous - #{id}"
      end
    end
  end
  
  def phone
    self.PhoneMobile
  end
  
  def first_name
    self.NameF
  end
  
  def last_name
    self.NameL
  end
  
  def email
    self.Email
  end
  
  def quick_pay(amount, receipt_number, device_id)
    from_account_id = company.transaction_account.blank? ? nil : company.transaction_account.id
    from_account = Account.find_by(ActID: from_account_id)
    to_account_id = accounts.first.id
    to_account = Account.find(to_account_id)
    requested_amount = amount.to_d
    fee_account_id = company.fee_account.blank? ? nil : company.fee_account.id
    fee_amount = 0
    # Create transfer transaction
    transaction = Transaction.create(amt_req: requested_amount, amt_auth: requested_amount, ChpFee: fee_amount, tran_code: 'TFR', sec_tran_code: 'CARD', 
      Description: "Transfer from #{company.CompanyName}", DevCompanyNbr: company.CompanyNumber, from_acct_id: from_account_id, to_acct_id: to_account_id, 
      receipt_nbr: receipt_number, dev_id: device_id, FeedActID: from_account_id, error_code: 0)
    # Create fee transaction
    # Transfer money between accounts
    unless from_account.blank?
      unless from_account.available_balance < requested_amount
        from_account.update_attribute('Balance', from_account.Balance - (requested_amount + fee_amount))
        to_account.update_attribute('Balance', to_account.Balance + requested_amount)
      else
        transaction.update(amt_auth: 0, error_code: 905) # Insufficient funds
      end
    else
      transaction.update(amt_auth: 0, error_code: 901) # From account invalid
    end
    # Transfer fee between accounts
    
    return transaction
  end
  
#  def customer_cards
#    CustomerCard.where(CustomerID: id)
#  end
  
  #############################
  #     Class Methods      #
  #############################
  
  
end