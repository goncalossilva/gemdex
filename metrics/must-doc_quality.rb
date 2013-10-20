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

include ActionView::Helpers::SanitizeHelper

print "user/repo: "
repo_url = gets.chomp

Dir.mktmpdir do |tmpdir|
  begin
    # Get README and write in temp dir
    readme = Octokit.readme(repo_url)
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
  repo =  Octokit.repository(repo_url)
  if repo.has_wiki
    `git clone --depth 1 git@github.com:#{repo_url}.wiki.git #{tmpdir}/wiki`
  end

  # Get all markdown/textile documentation
  html = ""
  Dir.glob("#{tmpdir}/**/*.*").each do |path|
    html << GitHub::Markup.render(path).html_safe
  end
  html.gsub!(/\n/, '')

  # Count code characters
  code_char_count = 0
  html.scan(/<code.*?>(.*?)<\/code>/m).flatten.map do |code|
    code_char_count += strip_tags(code).length
  end

  # Count total characters
  total_char_count = strip_tags(html).length

  # Print info
  puts "Total characters: #{total_char_count}"
  puts "Code characters: #{code_char_count}"
  puts "Code/total ratio: #{code_char_count / total_char_count.to_f}"
end
