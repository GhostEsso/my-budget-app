class AddUserRefToGroups < ActiveRecord::Migration[7.1]
  def change
    add_reference :groups, :user, null: false, foreign_key: { on_delete: :cascade }
  end
end
