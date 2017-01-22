class RPackagesController < ApplicationController
  def index
    @r_packages = RPackage.order(:name).page(params[:page])
  end

  def create
    @r_package = RPackage.new(article_params)
    @r_package.save
  end

  def show
    @r_package = RPackage.find(params[:id])
  end

  private

  def r_package_params
    params.require(:r_package).permit(:name, :version, :depends, :suggests, :license)
  end
end
