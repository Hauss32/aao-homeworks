class User < ApplicationRecord
    attr_reader :password
    after_initialize :ensure_session_token, :ensure_activation_code

    validates :email, :session_token, presence: true, uniqueness: true
    validates :password, length: { minimum: 8, allow_nil: true }

    has_many :notes

    def self.find_by_credentials(email, password)
        user = User.find_by(email: email)
        return nil unless user

        if user.correct_password?(password)
            return user
        else  
            return nil
        end
    end

    def password=(password)
        @password = password
        self.password_digest = digest_password(password)
    end

    def reset_session_token!
        self.session_token = generate_session_token
        self.save!
        self.session_token
    end

    def correct_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end
    
    private
    def ensure_session_token
        self.session_token ||= generate_session_token
    end

    def ensure_activation_code
        self.activation_code ||= SecureRandom.urlsafe_base64(16)
    end

    def generate_session_token
        SecureRandom.urlsafe_base64(16)
    end

    def digest_password(password)
        BCrypt::Password.create(password)
    end
end