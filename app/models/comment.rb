class Comment < ApplicationRecord
  belongs_to :blurb
  belongs_to :user

  has_rich_text :bloob
  validates :bloob, length: { minimum: 1, maximum: 500 }
end
