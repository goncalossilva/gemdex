#!/usr/bin/env ruby

require '../config/application'
require '../config/initializers/octokit'

print "user/repo: "
repo_url = gets.chomp

has_releases = Octokit.releases(repo_url).size > 0
if !has_releases
  tags = Octokit.tags repo_url
  tags.each do |tag|
    has_releases ^= /\d+.\d+/ === tag.name
    break if has_releases
  end
end

puts "Has releases: #{has_releases}"
