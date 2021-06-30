class BillHist < ApplicationRecord
#  self.primary_key = 'cassette_id'
#  self.primary_keys = :cassette_id, :dev_id #Composite primary keys
  self.table_name= 'bill_hist'
  
  belongs_to :device, :foreign_key => 'dev_id', optional: true
  belongs_to :company, optional: true
  
  scope :denomination, ->(denomination) { where("denomination = ?", denomination) unless denomination.blank?}
  scope :device, ->(dev_id) { where(dev_id: dev_id) unless dev_id.blank?}
  scope :cassette_id, ->(cassette_id) { where("cassette_id = ?", cassette_id) unless cassette_id.blank?}
  scope :user_name, ->(user_name) { where("user_name = ?", user_name) unless user_name.blank?}
  scope :cut_date, ->(cut_dt) { where('cut_dt = ?', cut_dt) unless cut_dt.blank?}
  scope :start_time, ->(start_time) { where('cut_dt >= ?', start_time.to_datetime) unless start_time.blank?}
  scope :end_time, ->(end_time) { where('cut_dt <= ?', end_time.to_datetime) unless end_time.blank?}
  
  validates_presence_of :dev_id
  validates_presence_of :cassette_id
  validates_presence_of :cut_dt
  validates_presence_of :denomination
  
  #############################
  #     Instance Methods      #
  #############################
  
  
  
  #############################
  #     Class Methods         #
  #############################
end