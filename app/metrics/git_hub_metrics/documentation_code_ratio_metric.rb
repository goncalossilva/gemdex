require 'github/markup'
module GitHubMetrics
  class DocumentationCodeRatioMetric < GitHubMetric
    include ActionView::Helpers::SanitizeHelper

    def score
      # Create temp dir where the README and wiki will be stored
      Dir.mktmpdir do |tmpdir|
        total_char_count = 0
        code_char_count = 0

        begin
          # Get README and store it in temp dir
          readme = Octokit.readme(@repo)
          File.open(File.join(tmpdir, readme.name), 'w') do |file|
            file.write(
              Base64.decode64(readme.content).encode(
                'UTF-8',
                {:invalid => :replace, :undef => :replace, :replace => '?'}
              )
            )
          end
        rescue Octokit::NotFound
          # No README, that's OK. Actually, that's not OK, but no reason to blow up.
        end

        # Clone wiki in temp dir
        repo =  Octokit.repository(@repo)
        if repo.has_wiki
          `git clone --depth 1 git@github.com:#{@repo}.wiki.git #{tmpdir}/wiki`
        end

        # Get all markdown/textile documentation
        html = ""
        Dir.glob("#{tmpdir}/**/*.*").each do |path|
          html << GitHub::Markup.render(path).html_safe
        end
        html.gsub!(/\n/, '')

        # Count code characters
        html.scan(/<code.*?>(.*?)<\/code>/m).flatten.map do |code|
          code_char_count += strip_tags(code).length
        end

        # Count total characters
        total_char_count = strip_tags(html).length

        # TODO
      end
    end

    def categories
      [:etiquette]
    end

    def categories_weights
      [8]
    end

    def expires_at
      1.day.from_now
    end
  end
end
