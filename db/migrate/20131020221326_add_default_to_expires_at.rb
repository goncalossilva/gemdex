class AddDefaultToExpiresAt < ActiveRecord::Migration
  def change
    change_column :metric_results, :expires_at, :datetime, :default => DateTime.new(0)
  end
end
