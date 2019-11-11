class CreateOokkeeAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :ookkee_accounts do |t|
      t.string :name
      t.string  :sheet_name # assets, liability, etc
    end

    add_index :ookkee_accounts, :sheet_name
  end
end
