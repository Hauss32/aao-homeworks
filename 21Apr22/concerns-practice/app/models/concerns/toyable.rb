module Toyable
    extend ActiveSupport::Concern

    included do
        validates :name, presence: true
        has_many :toys, as: :toyable
    end

    def receive_toy(name)
        Toy.create(name: name, toyable: self)
    end
end