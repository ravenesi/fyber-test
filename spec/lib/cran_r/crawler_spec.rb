RSpec.describe CranR::Crawler do
  context 'crawler intialization' do
    describe '#initialize' do
      it 'requires a cran package list service endpoint' do
        endpoint = ENV.delete('CRAN_PACKAGE_LIST')
        message = 'Missing CRAN_PACKAGE_LIST, set in .env file'

        expect do
          described_class.new(worker: PackageJob).index
        end.to raise_error(ArgumentError, message)

        ENV['CRAN_PACKAGE_LIST'] = endpoint
      end

      it 'requires worker parameter for specify who will parse data' do
        expect do
          described_class.new
        end.to raise_error('missing keyword: worker')
      end
    end
  end
  context 'crawler succeed' do
    it 'index all packages' do
      stub_request(:get, "https://cran.r-project.org/src/contrib/PACKAGES").
         to_return(status: 200, body: load_fixture('PACKAGES'), headers: {})

      crawler = described_class.new(worker: PackageJob)

      expect(PackageJob).to receive(:perform_later).exactly(4119).times
      expect(crawler.index).to be true
    end
  end

  context 'crawler failed' do
    it 'gracefully fail for 4xx errors' do
      stub_request(:get, "https://cran.r-project.org/src/contrib/PACKAGES").
           to_return(status: 404, body: '', headers: {})

      crawler = described_class.new(worker: PackageJob)

      expect(crawler.index).to be false
      expect(crawler.error).to eq 'Recieved HTTP: 404 from server'
    end

    it 'gracefully fail for 5xx errors' do
      stub_request(:get, "https://cran.r-project.org/src/contrib/PACKAGES").
           to_return(status: 500, body: '', headers: {})

      crawler = described_class.new(worker: PackageJob)

      expect(crawler.index).to be false
      expect(crawler.error).to eq 'Recieved HTTP: 500 from server'
    end
  end
end