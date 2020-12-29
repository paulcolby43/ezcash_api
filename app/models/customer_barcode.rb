class CustomerBarcode < ApplicationRecord
  self.primary_key = 'RowID'
  self.table_name= 'CustomerBarcode'
  
  belongs_to :device, :foreign_key => 'DevID', optional: true
  belongs_to :account, :foreign_key => 'ActID'
# belongs_to :transaction, :foreign_key => 'TranID'
# belongs_to :customer, :foreign_key => 'CustomerID'
 belongs_to :company, :foreign_key => 'CompanyNumber'
  
  scope :device, ->(dev_id) { where("DevID = ?", dev_id) unless dev_id.blank?}
  scope :customer_id, ->(customer_id) { where("CustomerID = ?", customer_id) unless customer_id.blank?}
  scope :company_number, ->(company_number) { where("CompanyNumber = ?", company_number) unless company_number.blank?}
  scope :barcode, ->(barcode) { where("Barcode = ?", barcode) unless barcode.blank?}
  scope :transaction_id, ->(transaction_id) { where("TranID = ?", transaction_id) unless transaction_id.blank?}
  scope :used, ->(used) { where("Used = ?", used) unless used.blank?}
  scope :account_id, ->(account_id) { where("ActID = ?", account_id) unless account_id.blank?}
  scope :start_time, ->(start_time) { where('date_time >= ?', start_time.to_datetime) unless start_time.blank?}
  scope :end_time, ->(end_time) { where('date_time <= ?', end_time.to_datetime) unless end_time.blank?}
  
  #############################
  #     Instance Methods      #
  #############################
  
  def used?
    self.Used == 1
  end
  
  def not_used?
    self.Used == 0
  end
  
  #############################
  #     Class Methods      #
  #############################
  
  
end