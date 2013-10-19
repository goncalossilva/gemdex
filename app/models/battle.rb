class Battle < ActiveRecord::Base
  belongs_to :rubygem_x, foreign_key: "rubygem_x_id", class_name: "Rubygem"
  belongs_to :rubygem_y, foreign_key: "rubygem_y_id", class_name: "Rubygem"

  accepts_nested_attributes_for :rubygem_x, reject_if: proc { |attributes| attributes['name'].blank? }
  accepts_nested_attributes_for :rubygem_y, reject_if: proc { |attributes| attributes['name'].blank? }

  validates_presence_of :rubygem_x
  validates_presence_of :rubygem_y

  def self.find_or_create_with_gems(rubygem_x, rubygem_y)
    if rubygem_x.errors.any? || rubygem_y.errors.any?
      error_battle = Battle.new
      return error_battle
    end

    battles = Battle.where(rubygem_x_id: [rubygem_x, rubygem_y], rubygem_y_id: [rubygem_x, rubygem_y])
    if battles.empty? || battles.nil?
      Battle.create(rubygem_x: rubygem_x, rubygem_y: rubygem_y)
    else
      battles.first
    end
  end
end