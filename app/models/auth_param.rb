class AuthParam < ApplicationRecord
#  self.primary_key = 'cassette_id'
#  
  belongs_to :device, :foreign_key => 'dev_id', optional: true
  belongs_to :company, optional: true
  
  scope :device, ->(dev_id) { where("dev_id = ?", dev_id) unless dev_id.blank?}
  scope :param_name, ->(param_name) { where("param_name = ?", param_name) unless param_name.blank?}
  scope :description, ->(description) { where("description = ?", description) unless description.blank?}
  scope :active_flag, ->(active_flag) { where("active_flag = ?", active_flag) unless active_flag.blank?}
  scope :clone_flag, ->(clone_flag) { where("clone_flag = ?", clone_flag) unless clone_flag.blank?}
  scope :val1_desc, ->(val1_desc) { where("val1_desc = ?", val1_desc) unless val1_desc.blank?} 
  scope :val1, ->(val1) { where("val1 = ?", val1) unless val1.blank?} 
  scope :val2_desc, ->(val2_desc) { where("val2_desc = ?", val2_desc) unless val2_desc.blank?} 
  scope :val2, ->(val2) { where("val2 = ?", val2) unless val2.blank?} 
  scope :val3_desc, ->(val3_desc) { where("val3_desc = ?", val3_desc) unless val3_desc.blank?} 
  scope :val3, ->(val3) { where("val3 = ?", val3) unless val3.blank?}   
  
  #############################
  #     Instance Methods      #
  #############################
  
  
  
  #############################
  #     Class Methods         #
  #############################
end