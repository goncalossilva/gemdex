require 'github/markup'

module GitHubMetrics
  class StarersMetric < GitHubMetric
    OPTIMAL_STARERS = 135

    def calculate_score
      repository = @client.repository @repo
      starers = repository.watchers_count

      # This is mostly a metric for rising projects. Famous gems obviously have
      # maximum popularity. Below 135 starers, degrade logarithmically.
      10 * Math.log10(1 + 10 / OPTIMAL_STARERS * 100)
    end

    def weight(category)
      {activity: 0, social: 8, etiquette: 0}[category]
    end

    def expires_at
      3.days.from_now
    end
  end
end
