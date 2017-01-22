require 'rails_helper'

RSpec.describe RPackage, type: :model do
  include ActiveJob::TestHelper

  before(:all) do
    @packages ||= RPackage.fetch_r_packages_file
  end

  describe 'validations' do
    it 'validates for missing name' do
      expect(RPackage.new).not_to be_valid
    end

    it 'is valid with name' do
      expect(RPackage.new(name: 'r_package_name')).to be_valid
    end
  end

  context 'class methods' do
    describe 'fetch_r_packages_file' do
      it "doensn't raise error" do
        expect{ @packages }.not_to raise_error
      end

      it 'returns a string' do
        expect(@packages).to be_a(String)
      end

      it 'contains Package, Version, Depends, Suggests, License' do
        keywords = %w(Package Version Depends Suggests License)

        keywords.each do |keyword|
          expect(@packages).to include(keyword)
        end
      end
    end

    describe 'convert_r_packages_file_to_hash' do
      it 'converts a string into a hash' do
        expect(RPackage.convert_r_packages_file_to_hash('Key: Value')).to eq([{ 'Key' => 'Value' }])
      end
    end

    describe 'store_r_packages_infos' do
      it 'pushes package_infos to the queue' do
        RPackage.store_r_packages_infos([{ 'Key' => 'Value' }, { '2nd' => 'Package' }])
        expect(ActiveJob::Base.queue_adapter.enqueued_jobs.count).to eq 2
      end
    end

    describe 'search' do
      before(:each) do
        RPackage.delete_all
        @first   = RPackage.create(name: 'ABCanalysis')
        @seccond = RPackage.create(name: 'AnglerCreelSurveySimulation')
      end

      it 'filters results' do
        expect(RPackage.search('ABCanalysis')).to eq([@first])
      end

      it "doesn't filter for empty string" do
        expect(RPackage.search('')).to eq([@first, @seccond])
      end

      it 'finds results in fuzzy way' do
        expect(RPackage.search('rveySim')).to eq([@seccond])
      end
    end
  end

  context 'instance methods' do
    describe 'read_description_infos_from_tar_and_store' do
      it 'updates r package entry' do
        allow(RPackage).to receive(:convert_r_packages_file_to_hash).and_return([{ 'Title' => 'ABCanalysis' }])
        package = RPackage.create(name: 'Something')
        allow(package).to receive(:read_description_from_package)
        package.read_description_infos_from_tar_and_store
        expect(package.long_name).to eq('ABCanalysis')
      end
    end
  end
end
