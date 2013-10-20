class GitHubMetric < Metric
  def initialize(repo)
    @client = Octokit::Client.new
    @repo = repo
  end

  def rate_limit
    rate_limit = @client.rate_limit
    {
      limit: rate_limit.limit,
      remaining: rate_limit.remaining,
      resets_at: rate_limit.resets_at,
      resets_in: rate_limit.resets_in
    }
  end
end
