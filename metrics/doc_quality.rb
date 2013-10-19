#!/usr/bin/env ruby

require '../config/application'
require '../config/initializers/octokit'
require 'github/markup'

# TODO:
# - Clean crazy loop
# - Check if project has wiki before trying to clone

# Devise: 0.338453816169089
# Carrierwave: 0.49669611986169804
# Mongoid Sequence: 0.44802207911683534
# Paperclip: 0.3417452574525745
# Active Merchant: 0.21226198376639951
# Delayed job: 0.20850118483412322
# Acts As Paranoid: 0.43928847641144625
# Spree: 0.09749739311783108
# Rails: 0.006367881618048396
class DocumentationCodeRatioCounter
  include ActionView::Helpers::SanitizeHelper

  def run
    print "user/repo: "
    repo_url = gets.chomp

    readme = Octokit.readme(repo_url)
    Dir.mktmpdir do |tmpdir|
      # Write REAME in temp dir
      File.open(File.join(tmpdir, readme.name), 'w') do |file|
        file.write(
          Base64.decode64(readme.content).encode(
            'UTF-8',
            {:invalid => :replace, :undef => :replace, :replace => '?'}
          )
        )
      end

      # Clone wiki in temp dir
      `git clone --depth 1 git@github.com:#{repo_url}.wiki.git #{tmpdir}/wiki`

      html = ""
      Dir.glob("#{tmpdir}/**/*.*").each do |path|
        html << GitHub::Markup.render(path).html_safe
      end
      html.gsub!(/\n/, '')

      code_char_count = html.scan(/<code.*?>(.*?)<\/code>/m).flatten.map do |s|
        strip_tags(s)
      end.map(&:length).inject(:+) || 0

      total_char_count = strip_tags(html).length

      puts total_char_count
      puts code_char_count
      puts code_char_count / total_char_count.to_f
    end
  end
end

DocumentationCodeRatioCounter.new.run
