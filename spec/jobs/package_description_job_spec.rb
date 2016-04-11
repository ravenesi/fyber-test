RSpec.describe PackageDescriptionJob do
  context 'success perform' do
    it 'update Package object and store all additional information' do
      stub_request(:get, "https://cran.r-project.org/src/contrib/A3_1.0.0.tar.gz").
         to_return(:status => 200, :body => load_fixture('A3_1.0.0.tar.gz'), :headers => {})

      package = create(:package, package_name: 'A3', version: '1.0.0')

      described_class.perform_now(package.id)

      package_data = package.reload.attributes.slice(*%w(
        status publication title description authors mainteners
      ))

      expect(package_data).to eq(
        "authors" => [{"name"=>"Scott Fortmann-Roe", "email"=>""}],
        "description" => "Supplies tools for tabulating and analyzing the " \
                         "results of predictive models. The methods employed " \
                         "are applicable to virtually any predictive model " \
                         "and make comparisons between different methodologies " \
                         "straightforward.",
        "publication" => "2015-08-16 23:05:52.000000000 +0000",
        "status" => 1,
        "title" => "Accurate, Adaptable, and Accessible Error Metrics for " \
                   "Predictive Models"
      )
    end
  end

  context 'failure during persisting package to DB' do
    it 'will fail because package not exist' do
      expect do
        described_class.perform_now(666)
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
