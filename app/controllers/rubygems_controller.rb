class RubygemsController < ApplicationController
  before_action :set_rubygem, only: [:show]
  # before_action :set_rubygem, only: [:show, :edit, :update, :destroy]

  # GET /rubygems
  # GET /rubygems.json
  # def index
  #   @rubygems = Rubygem.all
  # end

  # GET /rubygems/1
  # GET /rubygems/1.json
  def show
    if @rubygem.score_expired?
      @rubygem.refresh_score
    end
  end

  # GET /rubygems/new
  # def new
  #   @rubygem = Rubygem.new
  # end

  # GET /rubygems/1/edit
  # def edit
  # end

  # POST /rubygems
  # POST /rubygems.json
  def create
    @rubygem = Rubygem.new(rubygem_params)

    respond_to do |format|
      if @rubygem.save
        format.html { redirect_to @rubygem, notice: 'Rubygem was successfully created.' }
        format.json { render action: 'show', status: :created, location: @rubygem }
      else
        format.html { render action: 'new' }
        format.json { render json: @rubygem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rubygems/1
  # PATCH/PUT /rubygems/1.json
  # def update
  #   respond_to do |format|
  #     if @rubygem.update(rubygem_params)
  #       format.html { redirect_to @rubygem, notice: 'Rubygem was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: 'edit' }
  #       format.json { render json: @rubygem.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /rubygems/1
  # DELETE /rubygems/1.json
  # def destroy
  #   @rubygem.destroy
  #   respond_to do |format|
  #     format.html { redirect_to rubygems_url }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rubygem
      @rubygem = Rubygem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rubygem_params
      params.require(:rubygem).permit(:name, :full_name, :description, :watchers, :pushed_at, :forks, :open_issues)
    end
end
