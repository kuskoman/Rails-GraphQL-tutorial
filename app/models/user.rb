class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, length: { minimum: 3, maximum: 32 },
  	format: { with: /\A[0-9a-zA-Z]+([-._]?[0-9a-zA-Z]+)*\Z/}, uniqueness: true
  validates :password, presence: true, length: { minimum: 6, maximum: 72 }
end
