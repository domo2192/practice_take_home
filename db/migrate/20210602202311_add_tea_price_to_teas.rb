class AddTeaPriceToTeas < ActiveRecord::Migration[6.1]
  def change
    add_column :teas, :tea_price, :float
  end
end
