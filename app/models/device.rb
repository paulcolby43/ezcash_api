class Device < ApplicationRecord
  self.primary_key = 'dev_id'
  
  belongs_to :company, :foreign_key => "CompanyNbr"
  has_many :auth_params, :foreign_key => "dev_id"
  has_many :bill_counts, :foreign_key => 'dev_id'
  has_many :bill_hists, :foreign_key => 'dev_id'
  has_many :denoms, :foreign_key => 'dev_id', dependent: :destroy
  has_many :dev_statuses, :foreign_key => 'dev_id'
  has_many :fee_defs, :foreign_key => 'dev_id'
  has_many :statuses, through: :dev_statuses
  has_many :cards, :foreign_key => 'dev_id'
  
  scope :company_number, ->(company_nbr) { where("CompanyNbr = ?", company_nbr) unless company_nbr.blank?}
  
  accepts_nested_attributes_for :denoms, :reject_if => lambda { |d| d[:denomination].blank? or (d[:cassette_nbr].blank? and d[:cassette_id].blank?)}, allow_destroy: true
  
  #############################
  #     Instance Methods      #
  #############################
  
  
  
  #############################
  #     Class Methods        #
  #############################
end