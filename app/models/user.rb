class User < ActiveRecord::Base
  attr_accessible :admin, :email, :id, :name, :password_digest, :password_reset_sent_at, :password_reset_token, :token, :password
  
  validates_presence_of :name, :email, :password
  validates :name, :email, uniqueness: true

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
  
  private
  def generate_password(pass)
    salt = Array.new(10){rand(1024).to_s(36)}.join
    self.salt, self.password_digest = 
      salt, Digest::SHA256.hexdigest(pass + salt)
  end
end
