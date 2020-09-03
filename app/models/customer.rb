class Customer < ApplicationRecord
  self.primary_key = 'CustomerID'
  self.table_name= 'Customer'
  
  scope :company_number, ->(company_number) { where("CompanyNumber = ?", company_number) unless company_number.blank?}
  
  
  #############################
  #     Instance Methods      #
  #############################
  
  
  
  #############################
  #     Class Methods      #
  #############################
  
  
end