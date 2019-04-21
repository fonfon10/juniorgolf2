class TournamentsController < InheritedResources::Base
before_action :authenticate_user!
before_action :selectors, only: [:new, :edit]


def new
	@tournament = Tournament.new
end


def create
  @tournament = Tournament.new(tournament_params)
  @tournament.tour_id = params[:tour_id]
  @tournament.course_id = params[:course_id]
  @tournament.category_id = params[:category_id]
  @tournament.gender = params[:gender]
  @tournament.tour_id = params[:tour_id]
  @tournament.level_id = params[:level_id]

  if @tournament.save
    redirect_to tournaments_path
  else
    render 'new'
  end
	
end




def show
  @tournament = Tournament.find(params[:id])

  if (registration = Competition.find_by user: current_user, tournament: @tournament)
    @registration_status = registration.status.name

  else
    @registration_status = "Not Registered"
    
  end

  competitions = Competition.all
  @registered_comps = @tournament.competitions


  
end




def edit
  @tournament = Tournament.find(params[:id])
end


def index



#  if (current_user.gender.name == "Girls")
#   gender_id = [1,3]
#  else
#   gender_id = [2,3] 
#  end

#  case current_user.gender
#    when "01" 
#      gender = ["01","11"]
#    when "10"
#      gender = ["10","11"]
#    when "11" 
#      gender = ["01", "10", "11"]
#  end




  @tournaments_boys = []
  @tournaments_girls = []

  if current_user.gender_boy
    @tournaments_boys = Tournament.all.where("gender_boy = ?", true).order('start_time ASC')
  end

  if current_user.gender_girl
    @tournaments_girls = Tournament.all.where("gender_girl = ?", true).order('start_time ASC')
  end

  @tournaments_both = @tournaments_boys + @tournaments_girls
  @tournaments_both.uniq!

  @tournaments = []

  @tournaments_both.each do |t|

    if ((current_user.category_jun and t.category_jun) or
        (current_user.category_juv and t.category_juv) or      
        (current_user.category_ban and t.category_ban) or      
        (current_user.category_pee and t.category_pee) or      
        (current_user.category_ato and t.category_ato) )

    @tournaments << t

    end

  end

  @tournaments.uniq!


  Tournament.reorder('reg_deadline')
  competitions = Competition.all
  @competitions_of_interest = current_user.competitions.joins(:tournament).reorder('tournaments.reg_deadline')

  @competitions_status = Hash.new

  competitions.each do |comp|

    if comp.status.name != "No" and comp.status.name != nil

      if @competitions_status[comp.tournament.id] == nil 
        @competitions_status[comp.tournament.id] = 1
      else  
        @competitions_status[comp.tournament.id] = @competitions_status[comp.tournament.id] + 1
      end
      
    end

  end



end


def registered
  change_status (1)
end

def in_consideration
  change_status (2)
end

def wait_listed
  change_status (3)
end

def donot_attend
  change_status (4)
end



  private
    def selectors
  		@tours = Tour.order('name ASC').map { |i| [i.name, i.id]}			
  		@courses = Course.order('name ASC').map { |i| [i.name, i.id]}			
  		@categories = Category.order('id ASC').map { |i| [i.name, i.id]}			
  #		@genders = Gender.order('name ASC').map { |i| [i.name, i.id]}			
  		@tours = Tour.order('name ASC').map { |i| [i.name, i.id]}			
  		@levels = Level.order('id ASC').map { |i| [i.name, i.id]}			
  	end



  def change_status (status)
    @thisparticipation = Competition.all.find_by_tournament_id_and_user_id(params[:id], current_user.id)

    if @thisparticipation == nil
      @thisparticipation= Competition.create(:user_id => current_user.id,
                          :tournament_id => params[:id],
                          :status_id   => status)
    else
      @thisparticipation.status_id = status
    end

    @thisparticipation.save 
    redirect_to tournament_path
  end


    def tournament_params
      params.require(:tournament).permit(:name, :tour_id, :course_id, :category_id, :gender_boy, :gender_girl, :level_id, :days, :start_date, :reg_deadline, :qual_required, :comments)
    end
end

