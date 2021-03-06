class User < ActiveRecord::Base
  attr_accessible :admin, :email, :id, :name, :password_digest, :password_reset_sent_at, :password_reset_token, :token, :password, :cad_id, :avatar

  # 所有用户
  has_many :comments,   :dependent => :destroy
  has_many :notifications, :dependent => :destroy
  # 普通用户
  has_many :submits,    :dependent => :destroy
  # 管理员
  has_many :courses,    :dependent => :destroy
  has_many :feedbacks,  :dependent => :destroy

  validates_presence_of :name, :email, :on => :create
	# 只有create时才验证密码
	validates_presence_of :password, :on => :create
  validates :name, :email, uniqueness: true

  before_create { generate_token(:token) }
	mount_uploader :avatar, AvatarUploader

  
  def password
    @password
  end
  
  def password=(pass)
    return unless pass
    @password = pass
    generate_password(pass)
  end

  def self.authenticate(params)
    user = User.new(params[:name])
    if user && Digest::SHA256.hexdigest(password) == user.hashed_password
      return user
    end
    false
  end

  def self.authentication(email, password)
    user = User.find_by_email(email)
    if user && Digest::SHA256.hexdigest(password + user.salt) == user.password_digest
      return user
    end
    false
  end
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])  
  end
  
  def is_admin?
    return admin == 1
  end

  def notifications
    Notification.user_notifications(id)
  end
  
  # 数据表中存在的notifications数量，不管read还是unread
  def total_notifications
    Notification.total_notifications(id)
  end

  private
  def generate_password(pass)
    salt = Array.new(10){rand(1024).to_s(36)}.join
    self.salt, self.password_digest = 
      salt, Digest::SHA256.hexdigest(pass + salt)
  end

end
