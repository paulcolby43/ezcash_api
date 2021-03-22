class EzPermissionDesc < ActiveRecord::Base
  self.primary_key = 'PermissionID'
  self.table_name= 'ezPermissionDesc'
  
  belongs_to :role_permission, :foreign_key => "PermissionID"
  
end