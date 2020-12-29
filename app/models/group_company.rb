class GroupCompany < ApplicationRecord
  self.table_name= 'GroupCompanies'
  self.primary_keys = :GroupID, :CompanyNumber #Composite primary keys
  
  belongs_to :company, :foreign_key => "CompanyNumber"
  has_many :groups, :foreign_key => "GroupID"
  
  
  #############################
  #     Instance Methods      #
  #############################
  
  
  #############################
  #     Class Methods         #
  #############################
end