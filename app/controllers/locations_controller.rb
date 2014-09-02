class LocationsController < ApplicationController
    before_action :authenticate_user, :only => [:new, :create, :edit, :update, :destroy]
    before_action :set_location, :only => [:show, :edit, :update, :destroy]
    respond_to :json, :html

  def index
    if(!current_user)
      @locations = Location.all
    else
      @locations = Location.where(:user_id => current_user.id)
    end
    respond_with @locations
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
    # enables the export link to gather all data from locations and visitors and send to a excel file
    respond_to do |format|
      format.html { 
        @visits = @location.visits.group_by{ |x| x.created_at.to_date}
        respond_with @location 
      }
      format.xls { 
        @visitors = @location.visitors.order(:created_at)
        @visitors.each do |v|
          v.created_at = v.created_at.strftime("%I:%M")
        end
        send_data(@visitors.to_xls(
                                :prepend => [[@location.owner,@location.user.phone_number],
                                             [@location.user.agency],
                                             [@location.address],
                                             []],
                                :except => [:id,:updated_at, :created_at])) 
      }
    end
  end
# To send all data stored as a excel document
  def export
      respond_to do |format|
        format.html
        format.csv { render text: @locations.to_csv }
      end
  end

  def destroy
    @location.destroy
    respond_to do |format|
    format.html {redirect_to user_path, notice: 'Location was successfully removed.'}
    format.json {render json: :no_content }
    end
  end

  protected
    def set_location
      @location = Location.find(params[:id])
    end

    def location_params
      params.require(:location).permit(:owner, :address, :city, :state, :zip_code, :picture, :longitude, :latitude)
    end

end