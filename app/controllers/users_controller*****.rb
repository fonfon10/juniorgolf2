class UsersController < ApplicationController

before_action :authenticate_user!



def new
  @user = User.new
  @categories = Category.order('name ASC').map { |i| [i.name, i.id]}
 # @genders = Gender.order('name ASC').map { |i| [i.name, i.id]}


end

def create
  @user = User.new(user_params)
  @user.password = ("golf123")
  @user.password_confirmation = ("golf123")

  if @user.save
    redirect_to user_path
  else
    render 'new'
  end
  
end


def edit
  @user = User.find(params[:id])
 # @gender_bin_boy = @user.gender_id.to_s(2).rjust(2, "0")[0]
 # @gender_bin_girl = @user.gender_id.to_s(2).rjust(2, "0")[1]
end



  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :dob, :ovga_team, :gender_boy, :gender_girl, :category_id)
    end


end
