class CreateCustomerteas < ActiveRecord::Migration[6.1]
  def change
    create_table :customerteas do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :tea, null: false, foreign_key: true
      t.float :rating
      t.text :review

      t.timestamps
    end
  end
end
