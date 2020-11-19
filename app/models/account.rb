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
  
  
  #############################
  #     Class Methods         #
  #############################
end