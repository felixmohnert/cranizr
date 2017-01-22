class RPackagesController < ApplicationController
  def index
    @r_packages = RPackage.order(:name).page(params[:page]) || nil
  end

  def show
    @r_package = RPackage.find(params[:id])
  end
end
