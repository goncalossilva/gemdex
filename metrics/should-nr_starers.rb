#!/usr/bin/env ruby

require '../config/application'
require '../config/initializers/octokit'

print "user/repo: "
repo_url = gets.chomp

repo = Octokit.repository repo_url

puts "Starers: #{repo.watchers_count}"
