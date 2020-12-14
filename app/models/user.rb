class User < ApplicationRecord
  self.table_name= 'user_roles'
  self.primary_key = 'user_name'
  
  scope :user_name, ->(user_name) { where("user_name = ?", user_name) unless user_name.blank?}
  
  #############################
  #     Instance Methods      #
  #############################
  
#  def id
#    user_role_index
#  end
#  
  #############################
  #     Class Methods        #
  #############################
end