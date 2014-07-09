class VisitsController < ApplicationController
  def new
  	@visit = Visit.new
  	@location = Location.find(params[:location_id])
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

protected
    def visitor_params
      params.require(:visitor).permit(:first_name, :last_name, :email, :phone_number)
    end
end
