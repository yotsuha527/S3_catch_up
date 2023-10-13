class Room < ApplicationRecord
    has_many :messengers, dependent: :destroy
    has_many :messages, dependent: :destroy
end
