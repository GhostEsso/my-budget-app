class Purchase < ApplicationRecord
  has_many :group_purchases, dependent: :destroy
  has_many :groups, through: :group_purchases
  accepts_nested_attributes_for :group_purchases, allow_destroy: true
  # belongs_to :user
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  validates :name, presence: true, length: { maximum: 36 }
  validates :amount, presence: true, numericality: { money: true, greater_than_or_equal_to: 0 }
  validates_associated :group_purchases
end
