class VendorsController < InheritedResources::Base
  before_action :authenticate_user!

  private

    def vendor_params
      params.require(:vendor).permit(:full_name, :email, :phone, :address)
    end
end

