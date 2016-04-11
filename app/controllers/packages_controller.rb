class PackagesController < ApplicationController
  def index
    @packages = Package.processed
  end

  def show
    @package = Package.find_by(
      package_show_params
    )
  end

  def package_show_params
    params.permit(:id)
  end
end
