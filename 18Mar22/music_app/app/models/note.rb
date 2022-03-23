class Note < ApplicationRecord
    validates :body, length: { minimum: 1 }
    validates :user_id, uniqueness: {scope: [:track_id], 
        message: "has already made a comment."}
        

    belongs_to :track
    belongs_to :user
end