require 'github/markup'

module GitHubMetrics
  class HasReleasesMetric < GitHubMetric
    def score
      # Check if releases were ever used
      has_releases = !@client.releases(@repo).empty?

      # Check if release tags were ever used
      if !has_releases
        tags = @client.tags @repo
        tags.each do |tag|
          has_releases |= /\d+.\d+/ === tag.name
          break if has_releases
        end
      end

      # TODO
      puts "#{self.class.name} done!"
    end

    def categories
      [:social, :etiquette]
    end

    def categories_weights
      [2, 4]
    end

    def expires_at
      1.week.from_now
    end
  end
end
