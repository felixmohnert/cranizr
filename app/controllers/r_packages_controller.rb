class RPackagesController < ApplicationController
  def index
    @r_packages = RPackage.search(params[:search]).order(:name).page(params[:page])
  end

  def show
    @r_package = RPackage.find(params[:id])
  end
end
