class RolePermission < ActiveRecord::Base
  self.table_name= 'RolePermissions'
#  self.primary_key = 'RoleID'
  self.primary_keys = 'PermissionID', 'RoleID' #Composite primary keys
  
#  belongs_to :user, :foreign_key => "user_role_index"
  belongs_to :company
  has_one :ez_permission_desc, :foreign_key => "PermissionID"
  
  scope :role_id, ->(role_id) { where("RoleID = ?", role_id) unless role_id.blank?}
  scope :permission_id, ->(permission_id) { where("PermissionID = ?", permission_id) unless permission_id.blank?}
  
  #############################
  #     Instance Methods      #
  #############################
  
  def users
    User.where(user_role_index: self.RoleID)
  end
  
  #############################
  #     Class Methods         #
  #############################
  
end