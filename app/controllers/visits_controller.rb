class VisitsController < ApplicationController
     before_action :authenticate_user, :only => [:new, :create, :edit, :update, :destroy]
     # before_action :set_visit, :only => [:show, :edit, :update, :destroy]
     respond_to :json, :html
  def new
  	@visit = Visit.new
  	@location = Location.find(params[:location_id])
  end

  def show
    @location = Location.find(params[:location_id])
    # @visit = Location.find(params[:location_id]).visits.find(params[:id])
    respond_with @visit
  end

  def create
  	  @visitor = Visitor.new(visitor_params)
      if @visitor.save
        @visit = Visit.create(location_id: params[:location_id], visitor_id: @visitor.id)
        respond_to do |format|
	        flash[:success] = "visit successfully created"
	        format.html {redirect_to user_path(current_user)}
	        format.json { render json: @visit, status: :created}
	      end
      else
        respond_to do |format|
        flash[:danger] = "Visitor wasn't saved!()"
        format.html {render 'new'}
        format.json { render json: @visit.errors, status: :unprocessable_entity}
        end
      end
  end

  def edit
    @location = Location.find(params[:location_id])
    @visit = Visit.find(params[:id])

  end

  def update
   
    @visit = Visit.find(params[:id])
    @location = Location.find(params[:location_id])
    if @visit.visitor.update_attributes(visitor_params)
      respond_to do |format|
      format.html {redirect_to @location}
      format.json {render nothing: true, status: :no_content}
    end
    else
      respond_to do |format|
      format.html {render 'edit'}
      format.json { render json: @visit.errors, status: :unprocessable_entity}
    end
  end
end

  def destroy
     @visit = Visit.find(params[:id])
     @visit.destroy
     @location = Location.find(params[:location_id])
      respond_to do |format|
      format.html {redirect_to @location }
      
      format.json {render json: :no_content}
      end
    end
  

protected
    def visitor_params
      params.require(:visitor).permit(:first_name, :last_name, :email, :phone_number)
    end
end
