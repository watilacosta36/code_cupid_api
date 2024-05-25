class CreateCountryCodes < ActiveRecord::Migration[7.1]
  def change
    create_table :country_codes do |t|
      t.string :country
      t.string :dialingcode

      t.timestamps
    end
  end
end
