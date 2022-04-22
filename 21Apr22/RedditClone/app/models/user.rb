class User < ApplicationRecord
    include BCrypt

    after_initialize :ensure_session_token
    attr_reader :password

    validates :email, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: { minimum: 8, allow_nil: true }

    def self.find_by_creds(email, password)
        user = User.find_by(email: email)
        return nil unless user

        user.correct_password?(password) ? user : nil
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def correct_password?(password)
        return true if BCrypt::Password.new(self.password_digest).is_password?(password)

        false
    end

    def reset_session_token!
        new_token = generate_token
        self.update(session_token: new_token)
        new_token
    end

    private
    def generate_token
        SecureRandom.urlsafe_base64
    end

    def ensure_session_token
        self.session_token ||= generate_token
    end
end
