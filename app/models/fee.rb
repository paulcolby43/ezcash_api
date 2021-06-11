class Fee < ApplicationRecord
  
  belongs_to :device, optional: true
  belongs_to :company, optional: true
  
  #############################
  #     Instance Methods      #
  #############################
  
  
  
  #############################
  #     Class Methods         #
  #############################
end