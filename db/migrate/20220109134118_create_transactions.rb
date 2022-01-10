class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :counterparty_name
      t.string :counterparty_iban
      t.string :counterparty_bic
      t.integer :amount_cents
      t.string :amount_currency
      t.text :description
      t.references :bank_account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
