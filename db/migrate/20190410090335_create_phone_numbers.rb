class CreatePhoneNumbers < ActiveRecord::Migration[5.1]
  def change
    create_table :phone_numbers do |t|
      t.integer :number
      t.string :user
      t.boolean :fancy_number

      t.timestamps
    end
  end
end
