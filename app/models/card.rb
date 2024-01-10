class Card < ApplicationRecord
  belongs_to :user
  belongs_to :deck
  has_many :review_histories, dependent: :destroy

  enum status: {again: 0, hard: 1, good: 2, easy: 3}, _prefix: true
end
