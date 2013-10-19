class Battle < ActiveRecord::Base
  validates_presence_of :rubygem_x_id, :rubygem_y_id
end
