class CreateTwilioMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :twilio_messages do |t|
      t.string :phone_number
      t.string :twilio_message_sid

      t.timestamps
    end
  end
end
