class HomeController < ApplicationController
  def index
    @search = Search.new
    @battle = Battle.new
    @battle.build_rubygem_x
    @battle.build_rubygem_y
  end
end
