class CreateOokkeeSheets < ActiveRecord::Migration[6.0]
  def change
    create_table :ookkee_sheets do |t|
      t.string :title
      t.string :transaction_number
    end

    add_index :ookkee_sheets, :transaction_number, unique: true
  end
end
