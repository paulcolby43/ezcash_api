class Company < ApplicationRecord
  self.primary_key = 'CompanyNumber'
  self.table_name= 'Companies'
  
  has_many :accounts, :foreign_key => "CompanyNumber"
  has_many :account_types, :foreign_key => "CompanyNumber"
  has_many :customers, :foreign_key => "CompanyNumber"
  has_many :customer_barcodes, :foreign_key => "CompanyNumber"
  has_many :devices, :foreign_key => "CompanyNbr"
  has_many :users
  has_many :group_companies, :foreign_key => "CompanyNumber"
  has_many :transactions, :foreign_key => "DevCompanyNbr"
  has_many :auth_params, through: :devices
  has_many :bill_counts, through: :devices
  has_many :bill_hists, through: :devices
  has_many :denoms, through: :devices
  has_many :dev_statuses, through: :devices
  has_many :fee_defs, through: :devices
  has_many :groups, through: :group_companies
  has_many :role_permissions, through: :users
  has_many :statuses, through: :devices
  
  scope :company_number, ->(company_number) { where("CompanyNumber = ?", company_number) unless company_number.blank?}
  
  #############################
  #     Instance Methods      #
  #############################
  
  
  #############################
  #     Class Methods         #
  #############################
end