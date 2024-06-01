class AddColumnActiveToSubscriptions < ActiveRecord::Migration[7.1]
  def change
    add_column :subscriptions, :active, :boolean
  end
end
