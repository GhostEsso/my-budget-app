class CreateGroupPurchases < ActiveRecord::Migration[7.1]
  def change
    create_table :group_purchases do |t|

      t.timestamps
    end
  end
end
