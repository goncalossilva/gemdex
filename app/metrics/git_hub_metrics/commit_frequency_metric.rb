require 'github/markup'

module GitHubMetrics
  class CommitFrequencyMetric < GitHubMetric
    def score
      last_year_commits = 0
      recent_commits = 0

      cas = @client.commit_activity_stats(@repo)
      cas.each do |week_cas|
        last_year_commits += week_cas.total if week_cas.week > SINCE_DATE.to_i
        recent_commits += week_cas.total if week_cas.week > RECENT_SINCE_DATE.to_i
      end

      # TODO
      puts "#{self.class.name} done!"
    end

    def categories
      [:activity]
    end

    def categories_weights
      [10]
    end

    def expires_at
      1.day.from_now
    end
  end
end
