require 'github/markup'

module GitHubMetrics
  class HasNiceToHaveFilesMetric < GitHubMetric
    # Total: 10
    README_SCORE = 3.5
    LICENSE_SCORE = 3.5
    CONTRIBUTING_SCORE = 2.0
    CHANGELOG_SCORE = 1.0

    def calculate_score
      files = @client.contents(@repo, :path => '/')

      has_readme        = false
      has_license       = false
      has_contributing  = false
      has_changelog     = false

      files.each do |file|
        has_readme        |= /README/        === file.path
        has_license       |= /LICENSE/       === file.path
        has_contributing  |= /CONTRIBUTING/  === file.path
        has_changelog     |= /CHANGELOG/     === file.path
      end

      # Sum points based on important file presence
      0 +
      (has_readme ? README_SCORE : 0) +
      (has_license ? LICENSE_SCORE : 0) +
      (has_contributing ? CONTRIBUTING_SCORE : 0) +
      (has_changelog ? CHANGELOG_SCORE : 0)
    end

    def weight(category)
      {activity: 0, social: 2, etiquette: 8}[category]
    end

    def expires_at
      3.days.from_now
    end
  end
end
