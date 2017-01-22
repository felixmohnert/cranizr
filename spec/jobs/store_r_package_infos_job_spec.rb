require 'rails_helper'

RSpec.describe StoreRPackageInfosJob, type: :job do
  describe 'perform' do
    before (:each) do
      @package = RPackage.create(name: 'ABC', version: '0.0.2')
      allow_any_instance_of(RPackage).to receive(:read_description_infos_from_tar_and_store)
    end

    it 'finds and updates if package with same name & version exists' do
      expect {
        StoreRPackageInfosJob.perform_now({ "Package" => "ABC", "Version" => "0.0.2" })
      }.not_to change { RPackage.count }
    end

    it 'creates a new package entry when no package with same name and version exists' do
      expect {
        StoreRPackageInfosJob.perform_now({ "Package" => "New One", "Version" => "0.0.2" })
      }.to change { RPackage.count }.by(1)
    end

    it 'creates a new package entry when package name exists but version is different' do
      expect {
        StoreRPackageInfosJob.perform_now({ "Package" => "ABC", "Version" => "0.0.3" })
      }.to change { RPackage.count }.by(1)
    end
  end
end
