class User < ApplicationRecord
  self.table_name= 'user_roles'
  self.primary_key = 'user_name'
  
#  belongs_to :group, :foreign_key => "dev_group"
  belongs_to :company
#  has_many :role_permissions
  
  scope :user_name, ->(user_name) { where("user_name = ?", user_name) unless user_name.blank?}
  scope :company_id, ->(company_id) { where("company_id = ?", company_id) unless company_id.blank?}
  
  before_create :create_auth_token
  before_create :encrypt_password
  
  validates :user_name, uniqueness: true
  validates :api_auth_token, uniqueness: true
  
  #############################
  #     Instance Methods      #
  #############################
  
#  def as_json(options={})
#    super(except: [:pwd_hash])
#  end
  
#  def id
#    user_role_index
#  end

  def encrypt_password
    self.pwd_hash = Digest::MD5.hexdigest(pwd_hash)
  end
  
  def create_auth_token
    self.api_auth_token = SecureRandom.uuid.gsub(/\-/,'')
  end
  
  def role_permissions
    RolePermission.where(RoleID: user_role_index)
  end

  #############################
  #     Class Methods         #
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