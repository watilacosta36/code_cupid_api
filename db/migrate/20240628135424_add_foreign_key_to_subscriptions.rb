class AddForeignKeyToSubscriptions < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :subscriptions, :users if foreign_key_exists?(:subscriptions, :users)

    add_foreign_key :subscriptions, :users, on_delete: :cascade
  end
end
