every 1.day, :at => '12:00 pm' do
  runner 'CranR::Crawler.new(worker: PackageJob).index'
end