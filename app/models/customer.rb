class Customer < ApplicationRecord
  self.primary_key = 'CustomerID'
  self.table_name= 'Customer'
  
  scope :company, ->(company_id) { where("CompanyNumber = ?", company_id) unless company_id.blank?}
  
  belongs_to :company, :foreign_key => 'CompanyNumber'
  
  
  #############################
  #     Instance Methods      #
  #############################
  
  
  
  #############################
  #     Class Methods      #
  #############################
  
  
end