# == Schema Information
#
# Table name: people
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  house_id   :integer
#
# Foreign Keys
#
#  fk_rails_...  (house_id => houses.id)
#
class Person < ApplicationRecord
    validates :name, presence: true
    validates :house_id, presence: true

    belongs_to :house,
        primary_key: :id,
        foreign_key: :house_id,
        class_name: :House
end
