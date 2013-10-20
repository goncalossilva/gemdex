class Search < ActiveRecord::Base
  validates_presence_of :query
  serialize :results, Array

  after_create :cache_results

  private
  def cache_results
    self.results = []
    response = Octokit.search_repositories( self.query + " language:ruby fork:true", { page: 1, per_page: 10 } )
    response.items.each do |item|
      hashed_item = { name: item[:name], description: item[:description] }
      self.results << hashed_item
    end

    self.save
  end
end