class Search < ActiveRecord::Base
  validates_presence_of :query
end
