class CreateOokkeeEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :ookkee_entries do |t|
      t.integer :sheet_id
      t.string  :sheet_name # assets, liability, etc
      t.integer  :account_id # cash, bank payable
      t.string  :entry_type # credit/debit
      t.decimal :amount, scale: 10, precision: 30
      t.string  :trackable_type
      t.integer :trackable_id
    end

    add_index :ookkee_entries, :sheet_id
    add_index :ookkee_entries, :entry_type
    add_index :ookkee_entries, :sheet_name
    add_index :ookkee_entries, :account_id
    add_index :ookkee_entries, :trackable_type
    add_index :ookkee_entries, :trackable_id
  end
end
