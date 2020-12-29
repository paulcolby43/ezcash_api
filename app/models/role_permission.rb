class RolePermission < ActiveRecord::Base
  self.table_name= 'RolePermissions'
#  self.primary_key = 'RoleID'
  self.primary_keys = 'PermissionID', 'RoleID' #Composite primary keys
  
  belongs_to :user, :foreign_key => "RoleID"
  belongs_to :company
  
  scope :role_id, ->(role_id) { where("RoleID = ?", role_id) unless role_id.blank?}
  scope :permission_id, ->(permission_id) { where("PermissionID = ?", permission_id) unless permission_id.blank?}
end