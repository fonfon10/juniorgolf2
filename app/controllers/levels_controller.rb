class LevelsController < InheritedResources::Base

  private

    def level_params
      params.require(:level).permit(:name)
    end
end

