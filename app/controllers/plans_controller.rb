class PlansController < ApplicationController
	before_action :set_schedule, :only => [:index, :create, :new]
	before_action :set_plan, :only => [:show, :edit, :update, :destroy]
	load_and_authorize_resource :user

	def index
		@plan = @schedule.plans
	end

	def new
		@plan = Plan.new
		@hide_features_nav  = true
	end

	def create
		@plan = @schedule.plans.new(plan_params)
		@hide_features_nav  = true
		if @plan.save
			redirect_to user_schedules_path(@schedule.user)
		else
			render :new
		end
	end

	def show
	end

	def edit
	end

	def update
		if @plan.update_attributes(plan_params)
			redirect_to plan_path(@plan.schedule)
		else
			render :edit
		end
	end

	def destroy
		@plan.destroy
		redirect_to :back
	end

	private

	def plan_params
		params.require(:plan).permit(:activity, :activity_time)
	end

	def set_schedule
		@schedule = Schedule.find(params[:schedule_id])
	end

	def set_plan
		@plan = Plan.find(params[:id])
	end
end
