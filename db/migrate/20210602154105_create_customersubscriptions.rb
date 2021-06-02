class CreateCustomersubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :customersubscriptions do |t|
      t.references :customer, null: false, foreign_key:true 
      t.references :subscription, null: false, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end