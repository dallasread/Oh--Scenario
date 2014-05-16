class ScenariosController < ApplicationController
  before_action :set_website
  before_action :set_scenario, only: [:show, :edit, :update, :destroy]

  # GET /scenarios
  # GET /scenarios.json
  def index
    redirect_to @website
  end

  # GET /scenarios/1
  # GET /scenarios/1.json
  def show
    redirect_to edit_website_scenario_path(@scenario.website, @scenario)
  end

  # GET /scenarios/new
  def new
    @scenario = Scenario.new
  end

  # GET /scenarios/1/edit
  def edit
  end
  
  def run
    @scenario = @website.scenarios.find(params[:scenario_id])
    @run = @scenario.run
  end

  # POST /scenarios
  # POST /scenarios.json
  def create
    @scenario = @website.scenarios.new(scenario_params)

    respond_to do |format|
      if @scenario.save
        format.html { redirect_to website_scenario_run_path(@scenario.website, @scenario), notice: 'Scenario was successfully created.' }
        format.json { render :show, status: :created, location: @scenario }
      else
        format.html { render :new }
        format.json { render json: @scenario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scenarios/1
  # PATCH/PUT /scenarios/1.json
  def update
    respond_to do |format|
      if @scenario.update(scenario_params)
        format.html { redirect_to website_scenario_run_path(@scenario.website, @scenario), notice: 'Scenario was successfully updated.' }
        format.json { render :show, status: :ok, location: @scenario }
      else
        format.html { render :edit }
        format.json { render json: @scenario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scenarios/1
  # DELETE /scenarios/1.json
  def destroy
    @scenario.destroy
    respond_to do |format|
      format.html { redirect_to @scenario.website }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scenario
      @scenario = @website.scenarios.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scenario_params
      params.require(:scenario).permit(:name, steps_attributes: [:id, :action, :expects, :target, :ordinal, :_destroy])
    end
    
    def set_website
      @website = Website.find(params[:website_id])
    end
end
