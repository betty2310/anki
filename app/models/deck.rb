class Deck < ApplicationRecord
  belongs_to :user
  belongs_to :parent, class_name: Deck.name, optional: true
  has_many :children, class_name: Deck.name, foreign_key: :parent,
           dependent: :destroy

  has_many :cards, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  scope :is_parent, ->{where(parent_id: nil)}
end
