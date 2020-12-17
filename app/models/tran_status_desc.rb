class TranStatusDesc < ApplicationRecord
  self.primary_key = 'tran_status'
  self.table_name= 'tran_status_desc'
  
  scope :tran_status, ->(tran_status) { where("tran_status = ?", tran_status) unless tran_status.blank?}
  scope :short_description, ->(short_desc) { where("short_desc = ?", short_desc) unless short_desc.blank?}
  scope :long_description, ->(long_desc) { where("long_desc = ?", short_desc) unless long_desc.blank?}
  
  #############################
  #     Instance Methods      #
  #############################
  
  
  #############################
  #     Class Methods         #
  #############################
end