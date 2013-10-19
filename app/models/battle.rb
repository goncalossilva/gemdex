class Battle < ActiveRecord::Base
  belongs_to :rubygem_x, foreign_key: "rubygem_x_id", class_name: "Rubygem"
  belongs_to :rubygem_y, foreign_key: "rubygem_y_id", class_name: "Rubygem"

  accepts_nested_attributes_for :rubygem_x, reject_if: proc { |attributes| attributes['name'].blank? }
  accepts_nested_attributes_for :rubygem_y, reject_if: proc { |attributes| attributes['name'].blank? }

  validates_presence_of :rubygem_x
  validates_presence_of :rubygem_y
end