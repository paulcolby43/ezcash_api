class FeeDef < ApplicationRecord
  self.table_name= 'FeeDefs'
  self.primary_key = 'FeeID'
  
  belongs_to :device, :foreign_key => 'dev_id'
  belongs_to :company
  
  #############################
  #     Instance Methods      #
  #############################
  
  
  
  #############################
  #     Class Methods         #
  #############################
end