class User < ApplicationRecord
    attr_reader :password
    after_initialize :ensure_tokens

    validates :email, :session_token, :activation_token, presence: true, uniqueness: true
    validates :password, length: { minimum: 8, allow_nil: true }

    def self.find_by_credentials(email, password)
        user = User.find_by(email: email)
        return nil unless user

        return user if user.correct_password?(password)
        nil
    end

    def password=(password)
        @password = password
        self.password_digest = digest_password

        true
    end

    def correct_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def reset_session_token!
        self.session_token = create_token
        self.save
        self.session_token
    end

    private
    def ensure_tokens
        ensure_session_token
        ensure_activation_token
    end

    def ensure_session_token
        self.session_token ||= create_token
    end

    def ensure_activation_token
        self.activation_token ||= create_token
    end

    def digest_password
        BCrypt::Password.create(@password)
    end

    def create_token
        SecureRandom.urlsafe_base64
    end
end