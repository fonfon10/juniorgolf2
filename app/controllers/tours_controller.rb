class ToursController < InheritedResources::Base

before_action :countries, only: [:new, :edit]

def new
	@tour = Tour.new
end


def create
  @tour = Tour.new(tour_params)
  @tour.country_id = params[:country_id]

  if @tour.save
    redirect_to tours_path
  else
    render 'new'
  end
	
end


def edit
  @tour = Tour.find(params[:id])
end


  private
  	def countries
  		@countries = Country.order('name ASC').map { |i| [i.name, i.id]}			
  	end

    def tour_params
      params.require(:tour).permit(:acronym, :name, :country_id)
    end
end

