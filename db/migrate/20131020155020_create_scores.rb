class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.string :kind
      t.float :result
      t.datetime :expires_at

      t.timestamps
    end
  end
end
