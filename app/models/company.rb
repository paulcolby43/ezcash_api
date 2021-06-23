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
  
  after_create_commit :create_transaction_and_fee_accounts
  
  #############################
  #     Instance Methods      #
  #############################
  
  def name
    self.CompanyName
  end
  
  def fee_account
    accounts.find_by(ActID: self.FeeActID)
  end
  
  def transaction_account
    accounts.find_by(ActID: self.TxnActID)
  end
  
  def create_transaction_and_fee_accounts
    if self.transaction_account.blank?
      new_transaction_account_type = AccountType.create(CompanyNumber: self.CompanyNumber, AccountTypeDesc: "#{name} Transaction Wallet Type", CorpAcctFlag: 1)
      new_transaction_account = Account.create(CompanyNumber: self.CompanyNumber, MinBalance: -1000000, ActTypeID: new_transaction_account_type.id)
      self.update_column(:TxnActID, new_transaction_account.id)
    end
    if self.fee_account.blank?
      new_fee_account_type = AccountType.create(CompanyNumber: self.CompanyNumber, AccountTypeDesc: "#{name} Fee Wallet Type", CorpAcctFlag: 1)
      new_fee_account = Account.create(CompanyNumber: self.CompanyNumber, ActTypeID: new_fee_account_type.id)
      self.update_column(:FeeActID, new_fee_account.id)
    end
  end
  
  #############################
  #     Class Methods         #
  #############################
end