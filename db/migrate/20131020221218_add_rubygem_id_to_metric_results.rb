class AddRubygemIdToMetricResults < ActiveRecord::Migration
  def change
    add_column :metric_results, :rubygem_id, :integer
  end
end
