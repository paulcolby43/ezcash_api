class BillCount < ApplicationRecord
  self.primary_key = 'host_start_count'
  
  belongs_to :device, :foreign_key => 'dev_id'
  
  #############################
  #     Instance Methods      #
  #############################
  
  
  
  #############################
  #     Class Methods         #
  #############################
end