class ActiveRecord::Base
  def generate_unique_token(field)
    begin
      token = SecureRandom.base64(16)
    end until !self.class.exists?(field => token)

    token
  end
end

class User < ActiveRecord::Base

  after_initialize :ensure_session_token

  validates :email, :password_digest, :session_token, presence: true
  validates :email, :session_token, uniqueness: true

  has_many(:subs, class_name: 'Sub',
           foreign_key: :moderator_id, primary_key: :id)
  has_many(:posts, class_name: 'Post',
           foreign_key: :author_id, primary_key: :id)

  has_many(:comments, class_name: "Comment",
           foreign_key: :author_id, primary_key: :id)
          

  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)

    user && user.is_password?(password) ? user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password).to_s
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = generate_unique_token(:session_token)
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= generate_unique_token(:session_token)
  end


end
