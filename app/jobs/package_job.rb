require 'dcf'

class PackageJob < ActiveJob::Base
  queue_as :default

  def perform(raw_data)
    @raw_data = raw_data.force_encoding('iso-8859-1').encode('utf-8')

    if package.valid?
      package.save
      PackageDescriptionJob.perform_later(package.id)
    else
      raise ArgumentError.new('Package missing mandatory fields')
    end
  end

  private
  attr_reader :raw_data, :package_data

  def package
    @package ||= Package.find_or_initialize_by(
      package_name: package_data.fetch('Package', nil),
      version: package_data.fetch('Version', nil)
    )
  end

  def package_data
    @package_data = Dcf.parse(raw_data).try(:last) || {}
  end
end
