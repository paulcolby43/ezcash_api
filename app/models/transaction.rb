class Transaction < ApplicationRecord
  self.primary_key = 'tranID'
  self.table_name= 'transactions'
  
  belongs_to :device, :foreign_key => 'dev_id'
  
  scope :device, ->(dev_id) { where("dev_id = ?", dev_id) unless dev_id.blank?}
  scope :from_customer_id, ->(fromcustid) { where("FromCustID = ?", fromcustid) unless fromcustid.blank?}
  scope :start_time, ->(start_time) { where('date_time >= ?', start_time.to_datetime) unless start_time.blank?}
  scope :end_time, ->(end_time) { where('date_time <= ?', end_time.to_datetime) unless end_time.blank?}
  
  #############################
  #     Instance Methods      #
  #############################
  
  
  
  #############################
  #     Class Methods         #
  #############################
end