module SearchesHelper
  def path_to_rubygem_or_item(name)
    result = Rubygem.find_by_name(name)
    if result.nil?
      button_to name, {action: "create", controller: "rubygems", rubygem: { name: name } }
    else
      link_to name, rubygem_path(result)
    end
  end
end