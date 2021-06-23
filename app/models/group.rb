class Group < ApplicationRecord
  self.table_name= 'Groups'
  self.primary_key = 'GroupID'
  
  belongs_to :group_company, :foreign_key => "GroupID", optional: true
  has_many :users, :foreign_key => "dev_group"
  belongs_to :company, optional: true
  
  
  #############################
  #     Instance Methods      #
  #############################
  
  
  #############################
  #     Class Methods         #
  #############################
end