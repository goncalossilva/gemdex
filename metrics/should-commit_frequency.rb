#!/usr/bin/env ruby

require '../config/application'
require '../config/initializers/octokit'

print "user/repo: "
repo_url = gets.chomp

LAST_YEAR_TIME = 1.year.ago.to_i
RECENT_TIME = 2.months.ago.to_i

last_year_commits = 0
recent_commits = 0

cas = Octokit.commit_activity_stats(repo_url)
cas.each do |week_cas|
  last_year_commits += week_cas.total if week_cas.week > LAST_YEAR_TIME
  recent_commits += week_cas.total if week_cas.week > RECENT_TIME
end

puts "Last year commits: #{last_year_commits}"
puts "Recent commits: #{recent_commits}"
