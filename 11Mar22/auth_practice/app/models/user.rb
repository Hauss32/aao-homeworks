class User < ApplicationRecord
    attr_reader :password

    before_validation :ensure_session_token

    validates :username, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: { message: "Password can't be blank" }
    validates :password, length: { minimum: 6, allow_nil: true }

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        return nil unless user

        user.is_password? ? user : nil
    end

    def self.generate_session_token
        SecureRandom.urlsafe_base64(16)
    end

    def password=(password)
        @password = password
        self.password_digest = make_digest(password)
    end

    def reset_session_token!
        self.session_token = self.class.generate_session_token
        self.save!
        self.session_token
    end

    private
    def ensure_session_token
        self.session_token ||= self.class.generate_session_token
    end

    def correct_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def make_digest(password)
        BCrypt::Password.create(password)
    end
end
