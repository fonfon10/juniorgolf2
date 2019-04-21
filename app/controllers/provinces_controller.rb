class ProvincesController < InheritedResources::Base

  private

    def province_params
      params.require(:province).permit(:name)
    end
end

