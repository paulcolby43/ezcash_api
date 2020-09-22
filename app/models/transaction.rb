class Transaction < ApplicationRecord
  self.primary_key = 'tranID'
  self.table_name= 'transactions'
  
  belongs_to :device, :foreign_key => 'dev_id'
  
  scope :device, ->(dev_id) { where("dev_id = ?", dev_id) unless dev_id.blank?}
  scope :from_customer_id, ->(fromcustid) { where("FromCustID = ?", fromcustid) unless fromcustid.blank?}
  scope :to_customer_id, ->(tocustid) { where("ToCustID = ?", tocustid) unless tocustid.blank?}
  scope :from_account_id, ->(from_acct_id) { where("from_acct_id = ?", from_acct_id) unless from_acct_id.blank?}
  scope :to_account_id, ->(to_acct_id) { where("to_acct_id = ?", to_acct_id) unless to_acct_id.blank?}
  scope :transaction_code, ->(tran_code) { where("tran_code = ?", tran_code) unless tran_code.blank?}
  scope :secondary_transaction_code, ->(sec_tran_code) { where("sec_tran_code = ?", sec_tran_code) unless sec_tran_code.blank?}
  scope :error_code, ->(error_code) { where("error_code = ?", error_code) unless error_code.blank?}
  scope :original_transaction_id, ->(orig_tran_id) { where("OrigTranID = ?", orig_tran_id) unless orig_tran_id.blank?}
  scope :start_time, ->(start_time) { where('date_time >= ?', start_time.to_datetime) unless start_time.blank?}
  scope :end_time, ->(end_time) { where('date_time <= ?', end_time.to_datetime) unless end_time.blank?}
  
  #############################
  #     Instance Methods      #
  #############################
  
  
  
  #############################
  #     Class Methods         #
  #############################
end