require 'github/markup'

module GitHubMetrics
  class StarersMetric < GitHubMetric
    def score
      repository = @client.repository @repo
      starers = repository.watchers_count

      # TODO
      puts "#{self.class.name} done!"
    end

    def weight(category)
      {activity: 0, social: 8, etiquette: 0}[category]
    end

    def expires_at
      3.days.from_now
    end
  end
end
