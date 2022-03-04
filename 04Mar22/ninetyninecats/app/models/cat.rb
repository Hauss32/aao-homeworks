require 'action_view'

class Cat < ApplicationRecord
    include ActionView::Helpers::DateHelper

    COLORS = ['White', 'Orange', 'Brown', 'Black', 'Mix']

    validates :birth_date, :color, :name, :sex, :description, presense: true
    validates :color, inclusion: { in: COLORS, message: "%{value} is not a valid color" }
    validates :sex, inclusion: { in: ['M', 'F'], message: "Sex must be 'M' or 'F'" }

    def age
        time_ago_in_words(self.birth_date)
    end

    private

end