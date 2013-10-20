require 'github/markup'

module GitHubMetrics
  class IssuesResolutionMetric < GitHubMetric
    def score
      # Get repository info
      repository = @client.repository @repo

      # Get all closed issues since SINCE_DATE
      @client.auto_paginate = true
      closed_issues =  @client.issues(@repo, state: 'closed', since: SINCE_DATE.iso8601)

      # Get issues counts
      open_count    =  repository.open_issues_count
      closed_count  =  closed_issues.length

      # Get ratio of open issues vs total
      total_count = open_count + closed_count
      ratio = open_count / total_count

      # Get resolution times
      resolution_times = []
      closed_issues.each do |issue|
        next if issue.closed_at < issue.created_at
        closing_time = ((issue.closed_at - issue.created_at) / 1.day).to_i
        resolution_times.push closing_time
      end
      total   = resolution_times.inject(:+)
      average = total / resolution_times.count

      # TODO
      puts "#{self.class.name} done!"
    end

    def categories
      [:activity, :social]
    end

    def categories_weights
      [8, 2]
    end

    def expires_at
      3.days.from_now
    end
  end
end
