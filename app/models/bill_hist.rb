class BillHist < ApplicationRecord
  self.primary_key = 'old_start'
  self.table_name= 'bill_hist'
  
  belongs_to :device, :foreign_key => 'dev_id'
  
  scope :denomination, ->(denomination) { where("denomination = ?", denomination) unless denomination.blank?}
  scope :device, ->(dev_id) { where("dev_id = ?", dev_id) unless dev_id.blank?}
  scope :cassette_id, ->(cassette_id) { where("cassette_id = ?", cassette_id) unless cassette_id.blank?}
  scope :user_name, ->(user_name) { where("user_name = ?", user_name) unless user_name.blank?}
  scope :cut_date, ->(cut_dt) { where('cut_dt = ?', cut_dt) unless cut_dt.blank?}
  
  #############################
  #     Instance Methods      #
  #############################
  
  
  
  #############################
  #     Class Methods         #
  #############################
end