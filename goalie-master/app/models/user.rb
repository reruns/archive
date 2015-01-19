require 'bcrypt'

class User < ActiveRecord::Base
  include Commentable

  validates :username, :password_digest, :session_token, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  after_initialize :ensure_session_token

  attr_reader :password

  has_many :goals, dependent: :destroy

  has_many(
    :authored_comments,
    class_name: "Comment",
    foreign_key: :author_id
  )

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil unless user
    return user if user.is_password?(password)
    nil

  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

  def reset_session_token!
    self.session_token = generate_session_token
    self.save!
    self.session_token
  end

end
