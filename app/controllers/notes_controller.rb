class NotesController < ApplicationController
before_action :authenticate_user!


def new
	@tournament = Tournament.new
end


def create
  @tournament = Tournament.new(tournament_params)


  @tournament.tour_id = Tour.first
  @tournament.course_id = Course.first
  @tournament.gender_boy   = true
  @tournament.gender_girl   = true
  @tournament.level_id = Level.first
  @tournament.user = current_user
  @tournament.note = true



  if @tournament.save
    redirect_to tournaments_path
  else
    render 'new'
  end
	
end



  private

    def tournament_params
      params.require(:tournament).permit(:name, :comments, :start_time, :end_time, 
      					:mother, :father, :other_children)
    end
end







