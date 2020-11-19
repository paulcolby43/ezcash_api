class Company < ApplicationRecord
  self.primary_key = 'CompanyNumber'
  self.table_name= 'Companies'
  
  has_many :accounts, :foreign_key => "CompanyNumber"
  has_many :customers, :foreign_key => "CompanyNumber"
  
  
  #############################
  #     Instance Methods      #
  #############################
  
  
  #############################
  #     Class Methods         #
  #############################
end