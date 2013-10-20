#!/usr/bin/env ruby

require '../config/application'
require '../config/initializers/octokit'

print "user/repo: "
repo_url = gets.chomp

files = Octokit.contents(repo_url, :path => '/')

has_readme = false
has_license = false
has_contributing = false
has_changelog = false

files.each do |file|
  has_readme |= /README/ === file.path
  has_license |= /LICENSE/ === file.path
  has_contributing |= /CONTRIBUTING/ === file.path
  has_changelog |= /CHANGELOG/ === file.path
end

puts "Has readme: #{has_readme}"
puts "Has license: #{has_license}"
puts "Has cotnributing: #{has_contributing}"
puts "Has changelog: #{has_changelog}"
