class Battle < ActiveRecord::Base
  belongs_to :rubygem_x, foreign_key: "rubygem_x_id", class_name: "Rubygem"
  belongs_to :rubygem_y, foreign_key: "rubygem_y_id", class_name: "Rubygem"

  accepts_nested_attributes_for :rubygem_x
  accepts_nested_attributes_for :rubygem_y
end