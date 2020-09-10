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
  
  def denomination
#    denom = Denom.find_by dev_id: 201, cassette_nbr: 9
    denoms = Denom.device_and_cassette_nbr(self.dev_id, self.cassette_nbr)
    unless denoms.blank?
      return denoms.first.denomination
    else
      return nil
    end
  end
  
  def attributes_with_denomination
    as_json.merge({denomination: self.denomination})
  end
  
  #############################
  #     Class Methods         #
  #############################
end