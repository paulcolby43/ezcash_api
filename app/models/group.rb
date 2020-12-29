class Group < ApplicationRecord
  self.table_name= 'Groups'
  self.primary_key = 'GroupID'
  
  belongs_to :group_company, :foreign_key => "GroupID"
  has_many :users, :foreign_key => "dev_group"
  belongs_to :company
  
  
  #############################
  #     Instance Methods      #
  #############################
  
  
  #############################
  #     Class Methods         #
  #############################
end