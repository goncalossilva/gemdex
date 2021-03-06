#!/usr/bin/env ruby

require '../config/application'
require '../config/initializers/octokit'

include ActionView::Helpers::TextHelper

Octokit.per_page = 100

# example repos
## medium size
#@repo = 'saltstack/salt'
## small
#@repo = 'jdutil/contact_us'
## pico
@repo = 'jongilbraith/simple-private-messages'

# retrieve results for past year
start_date = 1.year.ago.iso8601

# fetch issues (open and closed)
repository = Octokit.repository @repo

old_auto_paginate = Octokit.auto_paginate
Octokit.auto_paginate = true
closed_issues =  Octokit.issues(@repo, :state => 'closed', :since => start_date)
Octokit.auto_paginate = old_auto_paginate

# get issues counts
open_count    =  repository.open_issues_count
closed_count  =  closed_issues.length

# ratio of open issues vs total
total_count = open_count + closed_count
ratio = open_count / total_count

@resolution_times = []
closed_issues.each do |issue|
  next if issue.closed_at < issue.created_at
  closing_time = ((issue.closed_at - issue.created_at) / 1.day).to_i
  @resolution_times.push closing_time
end

total = @resolution_times.inject :+
average = total / @resolution_times.count

puts "=== RESULTS ==="
puts "total open issues: #{open_count}"
puts "total closed issues: #{closed_count}"
puts "ratio of open issues in the past year: #{ratio}"
puts "average closing time: #{average} days"
