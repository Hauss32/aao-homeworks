class Note < ApplicationRecord
    validates :body, length: { minimum: 1, message: 'Comment cannot be blank.' }
    validates :user_id, uniqueness: {scope: [:track_id], 
        message: "Hey, you've already made a comment!"}
        

    belongs_to :track
    belongs_to :user
end