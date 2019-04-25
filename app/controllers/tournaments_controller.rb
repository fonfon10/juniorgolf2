class TournamentsController < InheritedResources::Base
before_action :authenticate_user!
before_action :selectors, only: [:new, :edit, :newnotes]


def new
	@tournament = Tournament.new

end


def create
  @tournament = Tournament.new(tournament_params)
  @tournament.tour_id = params[:tour_id]
  @tournament.course_id = params[:course_id]
  @tournament.level_id = params[:level_id]
  @tournament.user = current_user


  if @tournament.save
    redirect_to tournaments_path
  else
      render 'new'
  end
  
end

def create_notes
  @tournament = Tournament.new(tournament_params)
  @tournament.tour_id = params[:tour_id]
  @tournament.course_id = params[:course_id]
  @tournament.level_id = params[:level_id]
  @tournament.gender_boy = true
  @tournament.gender_girl = true
  @tournament.user = current_user
  @tournament.note = true


  if @tournament.save
    redirect_to tournaments_path
  else
      render 'new'
  end
  
end




def newnotes
  @tournament = Tournament.new


#  @tournament.tour_id = Tour.first
#  @tournament.course_id = Course.first
#  @tournament.gender_boy   = true
#  @tournament.gender_girl   = true
#  @tournament.level_id = Level.first
#  @tournament.user = current_user
#  @tournament.note = true



 # if @tournament.save
 #   redirect_to tournaments_path
 # else
 #   render 'newnotes'
 # end
  
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

  @tournaments_boys = []
  @tournaments_girls = []

  if current_user.gender_boy
    @tournaments_boys = Tournament.all.where("gender_boy = ?", true).order('note DESC')
  end

  if current_user.gender_girl
    @tournaments_girls = Tournament.all.where("gender_girl = ?", true).order('note DESC')
  end

  @tournaments_both = @tournaments_boys + @tournaments_girls
  @tournaments_both.uniq!

  @tournaments = []

  @tournaments_both.each do |t|

    if ((current_user.category_jun and t.category_jun) or
        (current_user.category_juv and t.category_juv) or      
        (current_user.category_ban and t.category_ban) or      
        (current_user.category_pee and t.category_pee) or      
        (current_user.category_ato and t.category_ato)) and 
        ((t.tour.acronym == "ROGC" and current_user.rogc_team) or
        (t.tour.acronym == "TO" and current_user.ovga_team) or
        (t.tour.acronym != "ROGC" and t.tour.acronym != "TO")) or
        (t.note and t.user == current_user) or 
        (t.note and t.user.id == 1)


    @tournaments << t

    end

  end

  @tournaments.uniq!


  Tournament.reorder('reg_deadline')
  competitions = Competition.all
  @competitions_of_interest = current_user.competitions.joins(:tournament).reorder('tournaments.reg_deadline')

  @competitions_list_tournament_id_yes = []
  @competitions_list_tournament_id_no = []

  @competitions_of_interest.each do |comp|
    if comp.status.name != "No"
      @competitions_list_tournament_id_yes << comp.tournament.id

    else
      @competitions_list_tournament_id_no << comp.tournament.id

    end
  end



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
  #		@categories = Category.order('id ASC').map { |i| [i.name, i.id]}			
  #		@genders = Gender.order('name ASC').map { |i| [i.name, i.id]}			
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
      params.require(:tournament).permit(:name, :tour_id, :course_id, 
        :gender_boy, :gender_girl, :fee, :url,
        :category_jun,:category_juv,:category_ban,:category_pee,:category_ato,  
        :comments, :start_time, :end_time, :level_id, :reg_deadline, :qual_required,
        :father, :mother, :other_children, :note)
    end
end





