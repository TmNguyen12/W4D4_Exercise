class User < ApplicationRecord
  validates :user_name, :session_token, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token

  attr_reader :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token
    self.session_token = User.generate_session_token
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)   # this is the .is_password? for BCrypt
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    if user && user.is_password?(password)
      return user
    else
      nil
    end

  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end


end
