#!/usr/bin/env ruby

require 'ap'
require '../config/application'
require '../config/initializers/octokit'

print "Search for: "
query = gets.chomp
result = Octokit.search_repositories(
  query + " language:ruby fork:true",
  {
    page: 1,
    per_page: 10
  }
)
puts "Total: #{result.total_count}"
puts "Results: #{result.items.size}"
result.items.each do |item|
  ap item.attrs
end
