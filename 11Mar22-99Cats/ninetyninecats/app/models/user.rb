class User < ApplicationRecord
    validates :username, :session_token, presence: false
    validates :session_token, uniqueness: true
    validates :password, presence: { message: 'Password must be 6 or more characters.',
         allow_nil: true }

end
