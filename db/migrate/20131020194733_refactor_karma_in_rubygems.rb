class RefactorKarmaInRubygems < ActiveRecord::Migration
  def change
    remove_column :rubygems, :activity_karma
    remove_column :rubygems, :etiquette_karma
    remove_column :rubygems, :social_karma
    add_column :rubygems, :categories_karma, :text
  end
end
