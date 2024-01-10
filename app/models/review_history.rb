class ReviewHistory < ApplicationRecord
  belongs_to :card

  enum status: {again: 0, hard: 1, good: 2, easy: 3}, _prefix: true

  validates :status, presence: true,
            inclusion: {in: ReviewHistory.statuses.keys}
end
