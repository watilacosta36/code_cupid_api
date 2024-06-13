class AddIndexToUsersGender < ActiveRecord::Migration[7.1]
  def change
    add_index :users, :gender
  end
end
