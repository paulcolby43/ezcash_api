class User < ApplicationRecord
  self.table_name= 'user_roles'
  self.primary_key = 'user_name'
  
#  belongs_to :group, :foreign_key => "dev_group"
  belongs_to :company
  has_many :role_permissions, :foreign_key => "RoleID"
  
  scope :user_name, ->(user_name) { where("user_name = ?", user_name) unless user_name.blank?}
  scope :company_id, ->(company_id) { where("company_id = ?", company_id) unless company_id.blank?}
  
#  before_create :set_auth_token
  
  #############################
  #     Instance Methods      #
  #############################
  
#  def as_json(options={})
#    super(except: [:pwd_hash])
#  end
  
#  def id
#    user_role_index
#  end

  #############################
  #     Class Methods        #
  #############################
  
  def self.authenticate(username, pass)
    user = self.where(user_name: username).first
    return user if user && user.pwd_hash == user.md5_encrypt_password(pass)
  end
  
  def md5_encrypt_password(pass)
    Digest::MD5.hexdigest(pass)
  end
  
  def set_auth_token
    self.update_attribute(:api_auth_token, generate_auth_token)
  end
 
  private
  
  def generate_auth_token
    SecureRandom.uuid.gsub(/\-/,'')
  end
  
end