class Like < ApplicationRecord
  belongs_to :user
  belongs_to :blurb

  validates :user_id, uniqueness: { scope: :blurb_id }
end
