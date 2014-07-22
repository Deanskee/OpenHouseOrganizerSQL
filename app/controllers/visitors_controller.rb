class VisitorsController < ApplicationController
    before_action :authenticate_user, :only => [:new, :create, :edit, :update, :destroy]
    before_action :set_visitor, :only => [:show, :edit, :update, :destroy]
    respond_to :json, :html

  def index
    if(!current_user)
      @visitors = Visitor.all
    else
      @visitors = current_user.visitors
      @visitors = Visitor.find( :all, :order => "created_at DESC")
      @visitors = @visitors.group_by(&:created_at.to_date.to_s(:db)).map{|k,v| [k,v.length]}.sort
    end
  end


  def new
    @visitor = Visitor.new
  end

  def create
    @visitor = current_user.visitors.new(visitor_params)
      if @visitor.save
        respond_to do |format|
        flash[:success] = "Visitor successfully created"
        format.html {redirect_to user_path(current_user)}
        format.json { render json: @visitor, status: :created}
      end
      else
        respond_to do |format|
        flash[:danger] = "Please enter a valid name ()"
        format.html {render 'new'}
        format.json { render json: @visitor.errors, status: :unprocessable_entity}
      end
    end
  end

  def edit
    respond_with @visitor
  end

  def update
    @location = Location.find(params[:location_id])
    if @visitor.update(visitor_params)
      respond_to do |format|
      format.html {redirect_to @location }
      format.json {render nothing: true, status: :no_content}
    end
    else
      respond_to do |format|
      format.html {render 'edit'}
      format.json { render json: @visitor.errors, status: :unprocessable_entity}
    end
  end
end

    def show
      respond_with @visitor
    end

    def destroy
     @visitor.destroy
    respond_to do |format|
    format.html {redirect_to user_path(current_user)}
    format.json {render json: :no_content}
      end
    end

  protected
    def set_visitor
      @visitor = Visitor.find(params[:id])
    end

    def visitor_params
      params.require(:visitor).permit(:id, :first_name, :last_name, :email, :phone_number, :note)
    end

end
