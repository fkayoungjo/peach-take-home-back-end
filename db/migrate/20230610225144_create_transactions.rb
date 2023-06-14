class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.string :transaction_name
      t.references :merchant, null: false, foreign_key: true
      t.decimal :amount
      t.date :date
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
