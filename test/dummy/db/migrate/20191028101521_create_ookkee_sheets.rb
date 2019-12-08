class CreateOokkeeSheets < ActiveRecord::Migration[6.0]
  def change
    create_table :ookkee_sheets do |t|
      t.string :title
      t.string :transaction_number

      t.string  :user_type
      t.integer :user_id

      t.timestamps
    end

    add_index :ookkee_sheets, :transaction_number
    add_index :ookkee_sheets, :user_type
    add_index :ookkee_sheets, :user_id
  end
end
