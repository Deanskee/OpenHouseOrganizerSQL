class UsersController < ApplicationController
   before_action :set_user, :only => [:show, :edit, :update, :destroy]
   before_action :login_required, :except => [:new, :create]
  # load_and_authorize_resource :except => [:new, :create]
   respond_to :json, :html
  def index
    @users = User.all
    respond_with @users
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      respond_to do |format|
      flash[:success] = "Thank you for signing up!"
      # UserMailer.welcome_email(@user).deliver
      session[:remember_token] = @user.id
      # session_create # This method is inhereited from the applicaiton_controller
      format.html  {redirect_to user_path(current_user), notice: "Welcome new user."}
      format.json { render json: @user, status: :created}
   end
    else
      respond_to do |format|
      flash[:danger] = "User could not be created"
      format.html {render :new}
      format.json { render json: @user.errors, status: :unprocessable_entity}
    end
    end
  end

  def show
    respond_with @user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
     if @user.update(user_params)
      respond_to do |format|
      format.html {redirect_to user_path}
      format.json {render nothing: true, status: :no_content}
     end
     else
      respond_to do |format|
      format.html {redirect_to edit_user_path, notice: 'User was successfully edited.'}
      format.json { render json:@user.errors, status: :unprocessable_entity}
     end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
    format.html {redirect_to new_user_path, notice: 'User was successfully destroyed.'}
    format.json {render json: :no_content}
  end
  end

  protected

  def set_user
    @user = User.where(id:params[:id]).first
  end

  def authorize_user
    unless current_user.id.to_s == params[:id]
      redirect_to user_path(current_user)
    end
  end

  def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :avatar, :phone_number, :agency)
    end
end