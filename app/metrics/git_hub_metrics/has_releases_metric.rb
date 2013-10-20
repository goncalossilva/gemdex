require 'github/markup'

module GitHubMetrics
  class HasReleasesMetric < GitHubMetric
    def calculate_score
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

      has_releases ? 10 : 0
    end

    def weight(category)
      {activity: 0, social: 2, etiquette: 4}[category]
    end

    def expires_at
      3.days.from_now
    end
  end
end
