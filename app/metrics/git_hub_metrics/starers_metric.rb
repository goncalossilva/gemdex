require 'github/markup'

module GitHubMetrics
  class StarersMetric < GitHubMetric
    def score
      repository = @client.repository @repo
      starers = repository.watchers_count

      # TODO
      puts "#{self.class.name} done!"
    end

    def categories
      [:social]
    end

    def categories_weights
      [8]
    end

    def expires_at
      1.week.from_now
    end
  end
end
