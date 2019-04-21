class CoursesController < InheritedResources::Base

before_action :countries, only: [:new, :edit]
before_action :provinces, only: [:new, :edit]


def new
	@course = Course.new
end


def create
  @course = Course.new(course_params)
  @course.country_id = params[:country_id]
  @course.province_id = params[:province_id]

  if @course.save
    redirect_to courses_path
  else
    render 'new'
  end
	
end


def edit
  @course = Course.find(params[:id])
end




  private
    def countries
  		@countries = Country.order('name ASC').map { |i| [i.name, i.id]}			
  	end

    def provinces
  		@provinces = Province.order('name ASC').map { |i| [i.name, i.id]}			
  	end


    def course_params
      params.require(:course).permit(:name, :address, :city, :province_id, :country_id, :zip, :url)
    end
end

