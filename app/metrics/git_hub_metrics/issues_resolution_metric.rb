require 'github/markup'

module GitHubMetrics
  class IssuesResolutionMetric < GitHubMetric
    CLOSE_TIME_RELEVANCE = 0.65
    OPEN_CLOSE_RATIO_RELEVANCE = 0.35

    OPTIMAL_CLOSE_TIME = 3

    RATIO_PENALTY_EXPONENT = 1.5

    def calculate_score
      # Get repository info
      repository = @client.repository @repo

      # Get all closed issues since SINCE_DATE
      @client.auto_paginate = true
      closed_issues =  @client.issues(@repo, state: 'closed', since: SINCE_DATE.iso8601)

      # Get issues counts
      open_count    =  repository.open_issues_count
      closed_count  =  closed_issues.length

      # Get ratio of closed issues vs total
      total_count = open_count + closed_count
      ratio = closed_count / total_count

      # Get resolution times
      resolution_times = []
      closed_issues.each do |issue|
        next if issue.closed_at < issue.created_at
        closing_time = ((issue.closed_at - issue.created_at) / 1.day).to_i
        resolution_times.push closing_time
      end
      total   = resolution_times.inject(:+)
      average = total / resolution_times.count

      # Do a weighted average of the issue closing time (logarithmical penalty)
      # and the open/close ratio (exponential penalty).
      CLOSE_TIME_RELEVANCE * 10 * (1 / Math.log10(1 + (10 / OPTIMAL_CLOSE_TIME - 1 / OPTIMAL_CLOSE_TIME) * average)) +
      OPEN_CLOSE_RATIO_RELEVANCE * 10 * (ratio ** RATIO_PENALTY_EXPONENT)
    end

    def weight(category)
      {activity: 10, social: 3, etiquette: 0}[category]
    end

    def expires_at
      3.days.from_now
    end
  end
end
