RSpec.describe CranR::CrawlerDescription do
  context 'crawler intialization' do
    describe '#initialize' do
      it 'requires source_url parameter for specify where to download package .tar.gz' do
        expect do
          described_class.new
        end.to raise_error('missing keyword: source_url')
      end
    end
  end
  context 'crawler succeed' do
    it 'fetch' do
      stub_request(:get, "https://cran.r-project.org/src/contrib/A3_1.0.0.tar.gz").
         to_return(status: 200, body: load_fixture('A3_1.0.0.tar.gz'), headers: {})

      crawler = described_class.new(
        source_url: "https://cran.r-project.org/src/contrib/A3_1.0.0.tar.gz"
      )

      expect(crawler.fetch).to eq(
       "Author" => [{:name=>"Scott Fortmann-Roe", :email=>""}],
       "Date" => "2015-08-15",
       "Date/Publication" => "2015-08-16 23:05:52",
       "Depends" => "R (>= 2.15.0), xtable, pbapply",
       "Description" => "Supplies tools for tabulating and analyzing the results of predictive models. The methods employed are applicable to virtually any predictive model and make comparisons between different methodologies straightforward.",
       "License" => "GPL (>= 2)",
       "Maintainer" => [{:name=>"Scott Fortmann-Roe", :email=>"scottfr@berkeley.edu"}],
       "NeedsCompilation" => "no",
       "Package" => "A3",
       "Packaged" => "2015-08-16 14:17:33 UTC; scott",
       "Repository" => "CRAN",
       "Suggests" => "randomForest, e1071",
       "Title" => "Accurate, Adaptable, and Accessible Error Metrics for Predictive Models",
       "Type" => "Package",
       "Version" => "1.0.0"
      )
      expect(crawler.success).to be true
    end
  end

  context 'crawler failed' do
    it 'fail to find DESCRIPTION file fail gracefully' do
      stub_request(:get, "https://cran.r-project.org/src/contrib/no_description.tar.gz").
         to_return(status: 200, body: load_fixture('no_description.tar.gz'), headers: {})

      crawler = described_class.new(
        source_url: "https://cran.r-project.org/src/contrib/no_description.tar.gz"
      )

      expect(crawler.fetch).to be nil
      expect(crawler.success).to be false
    end

    it 'gracefully fail for 4xx errors' do
      stub_request(:get, "https://cran.r-project.org/src/contrib/A3_1.0.0.tar.gz").
           to_return(status: 404, body: '', headers: {})

      crawler = described_class.new(
        source_url: "https://cran.r-project.org/src/contrib/A3_1.0.0.tar.gz"
      )

      crawler.fetch

      expect(crawler.success).to be false
      expect(crawler.error).to eq 'Recieved HTTP: 404 from server'
    end

    it 'gracefully fail for 5xx errors' do
      stub_request(:get, "https://cran.r-project.org/src/contrib/A3_1.0.0.tar.gz").
           to_return(status: 500, body: '', headers: {})

      crawler = described_class.new(
        source_url: "https://cran.r-project.org/src/contrib/A3_1.0.0.tar.gz"
      )

      crawler.fetch

      expect(crawler.success).to be false
      expect(crawler.error).to eq 'Recieved HTTP: 500 from server'
    end
  end
end