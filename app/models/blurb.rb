class Blurb < ApplicationRecord
  belongs_to :user

  validates :body, length: { minimum: 1, maximum: 1000 }

  has_rich_text :body

  has_many :comments, dependent: :destroy
  has_one_attached :picture
end
