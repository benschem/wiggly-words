class User < ApplicationRecord
  has_secure_password
  has_many :games

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
end
