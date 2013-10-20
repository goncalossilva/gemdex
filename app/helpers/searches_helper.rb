module SearchesHelper
  def path_to_rubygem_or_item(item)
    result = Rubygem.find_by_name(item[:name])
    if result.nil?
      button_to item[:name], {action: "create", controller: "rubygems", rubygem: { name: item[:name], description: item[:description], open_issues: item[:open_issues], pushed_at: item[:pushed_at], forks: item[:forks], watchers: item[:watchers], full_name: item[:full_name] } }
    else
      link_to item[:name], rubygem_path(result)
    end
  end
end
