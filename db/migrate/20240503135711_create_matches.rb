class CreateMatches < ActiveRecord::Migration[7.1]
  def change
    create_table :matches do |t|
      t.references :user, null: false, foreign_key: true
      t.references :matched_user, null: false, foreign_key: { to_table: :users }
      t.datetime :matched_at, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps
    end
  end
end
