class PackageDescriptionJob < ActiveJob::Base
  queue_as :default

  def perform(package_id)
    @package = Package.find(package_id)

    crawler = CranR::CrawlerDescription.new(
      source_url: package_source_url
    )
    data = crawler.fetch

    if crawler.success
      data_changed.merge!(
        publication: data.fetch('Date/Publication', ''),
        title: data.fetch('Title', ''),
        description: data.fetch('Description', ''),
        authors: data.fetch('Author', ''),
        maintainers: data.fetch('Maintainer', ''),
        status: :active
      )
    end

    package.update_attributes(
      data_changed
    )
  end

  private
  attr_reader :package, :data_changed

  def data_changed
    @data_changed ||= {
      status: :active
    }
  end

  def package_source_url
    [
      'https://cran.r-project.org/src/contrib/',
      package.package_name,
      '_',
      package.version,
      '.tar.gz'
    ].join
  end

end
