class DevStatus < ApplicationRecord
#  self.primary_key = 'date_time'
  self.primary_keys = :status, :dev_id #Composite primary keys
  self.table_name = 'dev_statuses'
  
  belongs_to :device, :foreign_key => 'dev_id'
  belongs_to :company
  
  scope :device, ->(dev_id) { where(dev_id: dev_id) unless dev_id.blank?}
  scope :status, ->(status) { where("status = ?", status) unless status.blank?}
  scope :start_time, ->(start_time) { where('date_time >= ?', start_time.to_datetime) unless start_time.blank?}
  scope :end_time, ->(end_time) { where('date_time <= ?', end_time.to_datetime) unless end_time.blank?}
  
  #############################
  #     Instance Methods      #
  #############################
  
  
  #############################
  #     Class Methods         #
  #############################
end