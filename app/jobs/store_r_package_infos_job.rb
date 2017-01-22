class StoreRPackageInfosJob < ApplicationJob
  queue_as :default

  def perform(r_package)
    package = RPackage.where(name: r_package['Package'], version: r_package['Version']).first_or_create(
      depends:  r_package['Depends'],
      suggests: r_package['Suggests'],
      license:  r_package['License']
    )

    package.read_description_infos_from_tar_and_store
  end
end
