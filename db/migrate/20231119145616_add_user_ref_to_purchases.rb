class AddUserRefToPurchases < ActiveRecord::Migration[7.1]
  def change
    add_reference :purchases, :author, null: false, foreign_key: { to_table: :users, on_delete: :cascade }
  end
end
