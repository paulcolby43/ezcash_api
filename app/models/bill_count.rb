class BillCount < ApplicationRecord
  self.primary_key = 'host_start_count'
  
  belongs_to :device, :foreign_key => 'dev_id'
  
  scope :device, ->(dev_id) { where("dev_id = ?", dev_id) unless dev_id.blank?}
  scope :cassette_nbr, ->(cassette_nbr) { where("cassette_nbr = ?", cassette_nbr) unless cassette_nbr.blank?}
  scope :cassette_id, ->(cassette_id) { where("cassette_id = ?", cassette_id) unless cassette_id.blank?}
  scope :status, ->(status) { where("status = ?", status) unless status.blank?}
  
  #############################
  #     Instance Methods      #
  #############################
  
  
  
  #############################
  #     Class Methods         #
  #############################
end