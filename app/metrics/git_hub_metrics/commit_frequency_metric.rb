require 'github/markup'

module GitHubMetrics
  class CommitFrequencyMetric < GitHubMetric
    def calculate_score
      last_year_commits = 0
      recent_commits = 0

      cas = @client.commit_activity_stats(@repo)
      cas.each do |week_cas|
        last_year_commits += week_cas.total if week_cas.week > SINCE_DATE.to_i
        recent_commits += week_cas.total if week_cas.week > RECENT_SINCE_DATE.to_i
      end

      now = Time.now
      last_year_days = ((now - SINCE_DATE) / 1.day).to_i
      recent_days = ((now - RECENT_SINCE_DATE) / 1.day).to_i

      time_scale = recent_days / last_year_days.to_f
      commit_scale = recent_commits / last_year_commits.to_f

      # If the commit frequency in recent time is at least 90% of the overall
      # time, give this the maximum score.
      # Otherwise degrade logarithmically.
      10 * Math.log10(1 + 9 * (commit_scale / time_scale))
    end

    def weight(category)
      {activity: 10, social: 0, etiquette: 0}[category]
    end

    def expires_at
      12.hours.from_now
    end
  end
end
