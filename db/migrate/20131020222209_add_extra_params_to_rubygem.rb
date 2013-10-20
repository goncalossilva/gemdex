class AddExtraParamsToRubygem < ActiveRecord::Migration
  def change
    add_column :rubygems, :open_issues, :integer
    add_column :rubygems, :pushed_at, :datetime
    add_column :rubygems, :forks, :integer
    add_column :rubygems, :watchers, :integer
  end
end
