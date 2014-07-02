class LocationsController < ApplicationController
    before_action :authenticate_user, :only => [:new, :create, :edit, :update, :destroy]
    before_action :set_location, :only => [:show, :edit, :update, :destroy]

    respond_to :json, :html
  def index
    @locations = Location.all
  end

  def new
    @location = Location.new
  end

  def create
    @location = current_user.locations.new(location_params)
     if @location.save
        respond_to do |format|
        flash[:success] = "Location successfully created"
        format.html {redirect_to user_path(current_user)}
        format.json { render json: @location, status: :created}
      end
      else
        respond_to do |format|
        flash[:danger] = "Please enter a valid address (address, state, and zip_code)"
        format.html {render 'new'}
        format.json { render json: @location.errors, status: :unprocessable_entity}
      end
      end
  end

  def edit
    respond_with @location
  end

  def update
    if @location.update(location_params)
      respond_to do |format|
      format.html {redirect_to user_path(current_user)}
      format.json {render nothing: true, status: :no_content}
    end
    else
      respond_to do |format|
      format.html {render 'edit'}
      format.json { render json:@location.errors, status: :unprocessable_entity}
    end
    end
  end
  def show
    respond_with @location
  end

  def destroy
     @location.destroy
    respond_to do |format|
    format.html {redirect_to user_path}
    format.json {render json: :no_content}
  end
  end

  protected
    def set_location
      @location = Location.find(params[:id])
    end

    def location_params
      params.require(:location).permit(:owner, :address, :city, :state, :zip_code, :picture)
    end

end