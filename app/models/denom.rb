class Denom < ApplicationRecord
#  seslf.primary_key = 'dev_id'
#  self.primary_key = 'cassette_id'
  self.primary_keys = :cassette_id, :dev_id #Composite primary keys
  
  belongs_to :device, :foreign_key => 'dev_id'
  belongs_to :company
  
  scope :denomination, ->(denomination) { where("denomination = ?", denomination) unless denomination.blank?}
  scope :device, ->(dev_id) { where("dev_id = ?", dev_id) unless dev_id.blank?}
  scope :cassette_nbr, ->(cassette_nbr) { where("cassette_nbr = ?", cassette_nbr) unless cassette_nbr.blank?}
  scope :cassette_id, ->(cassette_id) { where("cassette_id = ?", cassette_id) unless cassette_id.blank?}
  scope :currency_type, ->(currency_type) { where("currency_type = ?", currency_type) unless currency_type.blank?}
  scope :device_and_cassette_nbr, ->(dev_id, cassette_nbr) { where("dev_id = ? AND cassette_nbr = ?", dev_id, cassette_nbr) unless dev_id.blank? or cassette_nbr.blank?}
  
  #############################
  #     Instance Methods      #
  #############################
  
  
  
  #############################
  #     Class Methods         #
  #############################
end