class AddFieldsToRubygems < ActiveRecord::Migration
  def change
    add_column :rubygems, :karma, :integer
    add_column :rubygems, :activity_karma, :integer
    add_column :rubygems, :social_karma, :integer
    add_column :rubygems, :etiquette_karma, :integer
    add_column :rubygems, :queued, :boolean, default: false
    add_column :rubygems, :metadata, :text
  end
end
