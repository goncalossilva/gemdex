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

    def categories
      [:social, :etiquette]
    end

    def categories_weights
      [2, 8]
    end

    def expires_at
      1.week.from_now
    end
  end
end
