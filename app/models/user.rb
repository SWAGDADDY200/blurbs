class User < ApplicationRecord
  validates :name, presence: true, length: { minimum: 1, maximum: 16 }
  EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: EMAIL_FORMAT }, uniqueness: true

  before_save { self.email = email.downcase }

  has_many :blurbs, dependent: :destroy

  has_secure_password

  has_one_attached :image

  has_rich_text :bio

  validates :location, length: { minimum: 1, maximum: 30 }, if: :location_changed?

  has_one_attached :banner

  has_one :birthday

  validates :username, presence: true, length: { minimum: 1, maximum: 16 }, uniqueness: true

end
