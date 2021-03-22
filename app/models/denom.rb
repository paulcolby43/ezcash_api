class Denom < ApplicationRecord
#  seslf.primary_key = 'dev_id'
#  self.primary_key = 'cassette_id'
  self.primary_keys = :cassette_id, :dev_id #Composite primary keys
  
  belongs_to :device, :foreign_key => 'dev_id', optional: true
  belongs_to :company, optional: true
  
  scope :denomination, ->(denomination) { where("denomination = ?", denomination) unless denomination.blank?}
  scope :device, ->(dev_id) { where(dev_id: dev_id) unless dev_id.blank?}
  scope :cassette_nbr, ->(cassette_nbr) { where("cassette_nbr = ?", cassette_nbr) unless cassette_nbr.blank?}
  scope :cassette_id, ->(cassette_id) { where("cassette_id = ?", cassette_id) unless cassette_id.blank?}
  scope :currency_type, ->(currency_type) { where("currency_type = ?", currency_type) unless currency_type.blank?}
  scope :device_and_cassette_nbr, ->(dev_id, cassette_nbr) { where("dev_id = ? AND cassette_nbr = ?", dev_id, cassette_nbr) unless dev_id.blank? or cassette_nbr.blank?}
  
  after_create :create_bill_count
  before_destroy :delete_bill_count
  
  #############################
  #     Instance Methods      #
  #############################
  
  def bill_count
    BillCount.find([cassette_nbr, dev_id])
  end
  
  def create_bill_count
    BillCount.create(cassette_nbr: self.cassette_nbr, cassette_id: self.cassette_id, dev_id: self.dev_id, host_start_count: 0, host_cycle_count: 0, dev_start_count: 0, dev_cycle_count: 0, dev_divert_count: 0,
    added_count: 0, old_added: 0, status: 0)
  end
  
  def delete_bill_count
    bill_count = BillCount.find([cassette_nbr, dev_id])
    bill_count.destroy unless bill_count.blank?
  end
  
  #############################
  #     Class Methods         #
  #############################
end