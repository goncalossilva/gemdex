require 'github/markup'

module GitHubMetrics
  class DocumentationCodeRatioMetric < GitHubMetric
    include ActionView::Helpers::SanitizeHelper

    OPTIMAL_CODE_DOC_RATIO = 0.5

    def calculate_score
      total_char_count  = 0
      code_char_count   = 0

      # Create temp dir where the README and wiki will be stored
      Dir.mktmpdir do |tmpdir|
        begin
          # Get README and store it in temp dir
          readme = @client.readme @repo
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
        repository = @client.repository @repo
        `git clone --depth 1 git@github.com:#{@repo}.wiki.git #{tmpdir}/wiki` if repository.has_wiki

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
      end

      code_char_count >= total_char_count * OPTIMAL_CODE_DOC_RATIO

      # If the code/documentation ratio is 0.5, then perfect.
      # Otherwise degrade logarithmically.
      if total_char_count > 0
        10 * Math.log10(1 + (10 / OPTIMAL_CODE_DOC_RATIO - 1 / OPTIMAL_CODE_DOC_RATIO) * (code_char_count / total_char_count.to_f))
      else
        0
      end
    end

    def weight(category)
      {activity: 0, social: 2, etiquette: 8}[category]
    end

    def expires_at
      12.hours.from_now
    end
  end
end

# Devise: 0.338453816169089
# Carrierwave: 0.49669611986169804
# Mongoid Sequence: 0.44802207911683534
# Paperclip: 0.3417452574525745
# Active Merchant: 0.21226198376639951
# Delayed job: 0.20850118483412322
# Acts As Paranoid: 0.43928847641144625
# Spree: 0.09749739311783108
# Rails: 0.006367881618048396
