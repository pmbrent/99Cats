class User < ActiveRecord::Base

  validates :user_name, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true}

  after_initialize :ensure_session_token

  has_many :cats, dependent: :destroy

  has_many(
    :owned_cat_rental_requests,
    through: :cats,
    source: :cat_rental_requests
  )

  has_many(
    :cat_rental_requests
  )

  def self.find_by_credentials(user_name, password)
    user = User.find_by_user_name(user_name)
    return unless user
    user.is_password?(password) ? user : nil
  end

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def password
    @password
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end


end
