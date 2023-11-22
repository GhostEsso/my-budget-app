class GroupPurchase < ApplicationRecord
  belongs_to :group
  belongs_to :purchase

  validates :purchase, uniqueness: { scope: :group }
end
