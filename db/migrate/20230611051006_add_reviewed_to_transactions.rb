class AddReviewedToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :reviewed, :boolean
  end
end
