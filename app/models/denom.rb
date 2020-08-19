class Denom < ApplicationRecord
#  seslf.primary_key = 'dev_id'
  self.primary_key = 'cassette_id'
  
  belongs_to :device, :foreign_key => 'dev_id'
end