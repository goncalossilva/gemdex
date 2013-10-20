require 'github/markup'

module GitHubMetrics
  class HasNiceToHaveFilesMetric < GitHubMetric
    def score
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

      # TODO
      puts "#{self.class.name} done!"
    end

    def weight(category)
      {activity: 0, social: 2, etiquette: 8}[category]
    end

    def expires_at
      3.days.from_now
    end
  end
end
