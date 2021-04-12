class Card < ApplicationRecord
  self.primary_key = 'card_seq'
  
  belongs_to :device, :foreign_key => 'dev_id', optional: true
  belongs_to :company, optional: true
  
  before_create :create_barcode_hash
  
  #############################
  #     Instance Methods      #
  #############################
  
  def active?
    card_status == "AC"
  end
  
  def closed?
    card_status == "CL"
  end
  
  def void?
    card_status == "VD"
  end
  
  def barcode_from_hash
    amount_string = "%07d" % (self.card_amt * 100) # Create a 7 digit string of amount with cents, padding front with zeros if necessary
    date_string = self.issued_date.strftime('%Y%m%d')
    hash_string = self.card_nbr + amount_string + date_string + ENV['SECRET1']
    md5_string = Digest::MD5.hexdigest(hash_string).upcase
    result = md5_string.delete("^0-9").first(10) # Select first 10 digits
    while result.size < 10
      result = result + '0'
    end
    return result
  end
  
  def create_barcode_hash
    barcode = barcode_from_hash
    key = (device.blank? or device.encryption_key.blank?) ? '' : device.encryption_key
    temp_string = barcode + key + ENV['SECRET2']
    result = Digest::MD5.hexdigest(temp_string).upcase.first(16)
    self.barcodeHash = result
  end
  
  #############################
  #     Class Methods         #
  #############################
  
  def self.to_csv
    require 'csv'
    attributes = %w{last_activity_date issued_date card_status bank_id_nbr card_nbr dev_id receipt_nbr card_amt avail_amt}
    
    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |card|
        csv << attributes.map{ |attr| card.send(attr) }
      end
    end
  end
  
end