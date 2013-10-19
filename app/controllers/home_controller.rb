class HomeController < ApplicationController
  def index
    @search = Search.new
    @battle = Battle.new
  end
end
