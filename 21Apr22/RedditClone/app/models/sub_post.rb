class SubPost < ApplicationRecord
    validates :post_id, uniqueness: { scope: :sub_id }

    belongs_to :sub
    belongs_to :post
end
