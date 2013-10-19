class CreateBattles < ActiveRecord::Migration
  def change
    create_table :battles do |t|
      t.integer :rubygem_x_id
      t.integer :rubygem_y_id

      t.timestamps
    end
  end
end
