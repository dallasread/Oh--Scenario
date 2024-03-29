class WebsitesController < ApplicationController
  before_action :set_website, only: [:show, :edit, :update, :destroy]

  # GET /websites
  # GET /websites.json
  def index
    @websites = current_user.websites
  end

  # GET /websites/1
  # GET /websites/1.json
  def show
    @website.scenarios.map(&:run) if request.path == website_run_path(@website)
    @scenarios = @website.scenarios
    @passing_count = @scenarios.passing.count
    @scenarios_count = @scenarios.count
  end

  # GET /websites/new
  def new
    @website = Website.new
  end

  # GET /websites/1/edit
  def edit
  end

  # POST /websites
  # POST /websites.json
  def create
    @website = current_user.websites.new(website_params)

    respond_to do |format|
      if @website.save
        format.html { redirect_to @website, notice: 'Website was successfully created.' }
        format.json { render :show, status: :created, location: @website }
      else
        format.html { render :new }
        format.json { render json: @website.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /websites/1
  # PATCH/PUT /websites/1.json
  def update
    respond_to do |format|
      if @website.update(website_params)
        format.html { redirect_to @website, notice: 'Website was successfully updated.' }
        format.json { render :show, status: :ok, location: @website }
      else
        format.html { render :edit }
        format.json { render json: @website.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /websites/1
  # DELETE /websites/1.json
  def destroy
    @website.destroy
    respond_to do |format|
      format.html { redirect_to websites_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_website
      @website = current_user.websites.find(params[:id] ? params[:id] : params[:website_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def website_params
      params.require(:website).permit(:name, :default_url)
    end
end
