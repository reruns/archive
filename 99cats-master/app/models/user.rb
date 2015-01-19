class User < ActiveRecord::Base
  attr_reader :password

  validates :user_name, :password_digest, :session_token, presence: true
  validates :user_name, :session_token, uniqueness: true
  validates :password, length: {minimum: 6}, allow_nil: true

  after_initialize :set_session_token!

  has_many(:cats, class_name: 'Cat', foreign_key: :user_id, primary_key: :id)
  has_many(:requests, class_name: 'CatRentalRequest', foreign_key: :user_id, primary_key: :id)
  has_many(:sessions, class_name: 'Session', inverse_of: :user,
           foreign_key: :user_id, primary_key: :id)

  def self.find_by_credentials(credentials)
    user_name, password = credentials[:user_name], credentials[:password]
    user = find_by_user_name(user_name)
    return nil unless user && user.is_password?(password)
    user
  end

  def set_session_token!
    self.session_token ||= SecureRandom::urlsafe_base64
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

end
