class StatusDesc < ApplicationRecord
  self.primary_key = 'status'
  self.table_name= 'status_desc'
  
  scope :status, ->(status) { where("status = ?", status) unless status.blank?}
  scope :short_description, ->(short_desc) { where("short_desc = ?", short_desc) unless short_desc.blank?}
  scope :caution_flag, ->(caution_flag) { where("caution_flag = ?", caution_flag) unless caution_flag.blank?}
  scope :alert_flag, ->(alert_flag) { where("alert_flag = ?", alert_flag) unless alert_flag.blank?}
  
  #############################
  #     Instance Methods      #
  #############################
  
  
  #############################
  #     Class Methods         #
  #############################
end