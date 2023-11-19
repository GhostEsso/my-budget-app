class User < ApplicationRecord
  has_many :purchases, foreign_key: 'author_id', dependent: :destroy
  has_many :groups, dependent: :destroy

  validates :name, presence: true, length: { maximum: 36 }
end
