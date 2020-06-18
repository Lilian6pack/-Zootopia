class ChangeHourPriceColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :animals, :hour_price, :daily_price
  end
end
