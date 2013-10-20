class RenameScoresToMetricResults < ActiveRecord::Migration
  def change
    rename_table :scores, :metric_results
  end
end
