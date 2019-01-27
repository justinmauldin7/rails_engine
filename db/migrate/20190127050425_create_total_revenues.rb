class CreateTotalRevenues < ActiveRecord::Migration[5.2]
  def change
    create_table :total_revenues do |t|

      t.timestamps
    end
  end
end
