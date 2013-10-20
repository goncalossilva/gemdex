class AddDescriptionFullNameToRubygem < ActiveRecord::Migration
  def change
    add_column :rubygems, :description, :text
    add_column :rubygems, :full_name, :string
  end
end
