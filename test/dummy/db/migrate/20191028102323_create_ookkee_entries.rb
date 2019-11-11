class CreateOokkeeEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :ookkee_entries do |t|
      t.integer :sheet_id
      t.string  :sheet_name # assets, liability, etc
      t.string  :account_id # cash, bank payable
      t.string  :entry_type # credit/debit
      t.integer :amount_cents, default: 0
      t.string  :trackable_type
      t.integer :trackable_id

      t.string  :user_type
      t.integer :user_id
    end

    add_index :ookkee_entries, :sheet_id
    add_index :ookkee_entries, :entry_type
    add_index :ookkee_entries, :sheet_name
    add_index :ookkee_entries, :acount_id
    add_index :ookkee_entries, :trackable_type
    add_index :ookkee_entries, :trackable_id
    add_index :ookkee_entries, :user_type
    add_index :ookkee_entries, :user_id
  end
end
