desc 'This task is called by the Heroku scheduler add-on on production'
task fetch_r_packages_at_12pm: :environment do
  puts 'Fetching r_packages file'
  file = RPackage.fetch_r_packages_file
  puts 'Done. Convert file to hash.'
  r_packages_hash = RPackage.convert_r_packages_file_to_hash(file)
  puts 'Done. Enqueue update jobs'
  RPackage.store_r_packages_infos(r_packages_hash)
  puts 'Success!'
end
