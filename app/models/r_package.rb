require 'dcf'
require 'open-uri'
require 'rubygems/package'
require 'zlib'

class RPackage < ApplicationRecord
  validates :name, presence: true

  R_PACKAGES_FILE_URL = 'https://cran.r-project.org/src/contrib/PACKAGES'.freeze

  def self.fetch_r_packages_file
    open(R_PACKAGES_FILE_URL, &:read)
  end

  def self.convert_r_packages_file_to_hash(file)
    Dcf.parse(file)
  end

  def self.store_r_packages_infos(r_packages)
    r_packages.each do |r_package|
      StoreRPackageInfosJob.perform_later(r_package)
    end
  end

  def self.search(search)
    where('name ILIKE ?', "%#{search}%")
  end

  def read_description_infos_from_tar_and_store
    r_package_hash = self.class.convert_r_packages_file_to_hash(read_description_from_package).first
    update(
      long_name:        r_package_hash['Title'],
      version_date:     r_package_hash['Date'],
      authors:          r_package_hash['Author'],
      maintainer_name:  r_package_hash['Maintainer'],
      maintainer_email: r_package_hash['Maintainer'],
      description:      r_package_hash['Description'],
      repository:       r_package_hash['Repository'],
      packaged_at:      r_package_hash['Packaged'],
      packaged_by:      r_package_hash['Packaged'],
      publication_at:   r_package_hash['Date/Publication']
    )
  end

  private

  def read_description_from_package
    uncompressed = Gem::Package::TarReader.new(Zlib::GzipReader.new(open(r_package_url)))

    text = uncompressed.detect do |f|
      f.full_name == "#{name}/DESCRIPTION"
    end.read
  end

  def r_package_url
    "https://cran.r-project.org/src/contrib/#{name}_#{version}.tar.gz"
  end
end
