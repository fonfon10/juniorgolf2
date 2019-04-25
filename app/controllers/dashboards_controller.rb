class DashboardsController < ApplicationController
before_action :authenticate_user!

  def index

  	@users = User.all

  end



  def toggle_ovga_team
  	@this_toggle = User.all.find(params[:id])

  	@this_toggle.ovga_team = !@this_toggle.ovga_team

    if @this_toggle.ovga_team == nil 
    	@this_toggle.ovga_team = false
    end

    @this_toggle.save

    redirect_to dashboards_path
  end

  def toggle_rogc_team
  	@this_toggle = User.all.find(params[:id])

  	@this_toggle.rogc_team = !@this_toggle.rogc_team

    if @this_toggle.rogc_team == nil 
    	@this_toggle.rogc_team = false
    end

    @this_toggle.save

    redirect_to dashboards_path
  end

  def toggle_operator_user
  	@this_toggle = User.all.find(params[:id])

  	operator_type = UserType.find_by name: "Operator"

  	@this_toggle.user_type = operator_type

    @this_toggle.save

    redirect_to dashboards_path
  end



  private







end
