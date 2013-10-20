class BattlesController < ApplicationController
  before_action :set_battle, only: [:show, :edit, :update, :destroy]

  # GET /battles
  # GET /battles.json
  # def index
  #   @battles = Battle.all
  # end

  # GET /battles/1
  # GET /battles/1.json
  def show
  end

  # GET /battles/new
  # def new
  #   @battle = Battle.new
  # end

  # GET /battles/1/edit
  # def edit
  # end

  # POST /battles
  # POST /battles.json
  def create
    rubygem_x = Rubygem.find_or_create_by(battle_params[:rubygem_x_attributes])
    rubygem_y = Rubygem.find_or_create_by(battle_params[:rubygem_y_attributes])

    @battle = Battle.find_or_create_with_gems(rubygem_x, rubygem_y)

    rubygem_x.refresh_score if rubygem_x.score_expired?
    rubygem_y.refresh_score if rubygem_y.score_expired?

    respond_to do |format|
      if @battle.save
        format.html { redirect_to @battle, notice: 'Battle was successfully created.' }
        # format.json { render action: 'show', status: :created, location: @battle }
      else
        format.html { redirect_to root_url(anchor: 'battle'), alert: @battle.errors }
        # format.json { render json: @battle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /battles/1
  # PATCH/PUT /battles/1.json
  # def update
  #   respond_to do |format|
  #     if @battle.update(battle_params)
  #       format.html { redirect_to @battle, notice: 'Battle was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: 'edit' }
  #       format.json { render json: @battle.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /battles/1
  # DELETE /battles/1.json
  # def destroy
  #   @battle.destroy
  #   respond_to do |format|
  #     format.html { redirect_to battles_url }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_battle
      @battle = Battle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def battle_params
      params.require(:battle).permit(rubygem_x_attributes: [:name], rubygem_y_attributes: [:name])
    end
end
