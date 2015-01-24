require 'base64'
class ScreenshotsController < ApplicationController
  before_action :set_screenshot, only: [:show, :edit, :update, :destroy]

  # GET /screenshots
  # GET /screenshots.json
  def index
    @screenshots = Screenshot.all
  end

  # GET /screenshots/1
  # GET /screenshots/1.json
  def show
  end

  # GET /screenshots/new
  def new
    @screenshot = Screenshot.new
  end

  # GET /screenshots/1/edit
  def edit
  end

  # POST /screenshots
  # POST /screenshots.json
  def create
    if screenshot_params['data_uri']
      data = screenshot_params['data_uri']
      image_data = Base64.decode64(data['data:image/png;base64,'.length .. -1])
      File.open("#{Rails.root}/public/uploads/tmp/#{screenshot_params['season']}-#{screenshot_params['episode_number']}-#{screenshot_params['time']}.png", 'wb') do |f|
        f.write image_data
      end
    end
    
    @screenshot = Screenshot.new(screenshot_params)
    
    @screenshot.attachment = File.open("#{Rails.root}/public/uploads/tmp/#{screenshot_params['season']}-#{screenshot_params['episode_number']}-#{screenshot_params['time']}.png", 'r+')
    File.delete("#{Rails.root}/public/uploads/tmp/#{screenshot_params['season']}-#{screenshot_params['episode_number']}-#{screenshot_params['time']}.png")
    
    respond_to do |format|
      if @screenshot.save
        attachment_no_datauri = 
        format.js { render json: @screenshot.attachment, status: :ok }
        format.html { redirect_to @screenshot, notice: 'Screenshot was successfully created.' }
        format.json { render :show, status: :created, location: @screenshot }
      else
        format.html { render :new }
        format.json { render json: @screenshot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /screenshots/1
  # PATCH/PUT /screenshots/1.json
  def update
    respond_to do |format|
      if @screenshot.update(screenshot_params)
        format.html { redirect_to @screenshot, notice: 'Screenshot was successfully updated.' }
        format.json { render :show, status: :ok, location: @screenshot }
      else
        format.html { render :edit }
        format.json { render json: @screenshot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /screenshots/1
  # DELETE /screenshots/1.json
  def destroy
    @screenshot.destroy
    respond_to do |format|
      format.html { redirect_to screenshots_url, notice: 'Screenshot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_screenshot
      @screenshot = Screenshot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def screenshot_params
      params.require(:screenshot).permit(:attachment, :season, :episode_number, :time, :data_uri)
    end
end
