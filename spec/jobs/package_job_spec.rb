RSpec.describe PackageJob do
  context 'success perform' do
    it 'create Package object and store all available information' do
      expect(PackageDescriptionJob).to receive(:perform_later).once

      described_class.perform_now(load_fixture('PACKAGE'))

      expect(Package.count).to be 1
      expect(Package.last.package_name).to eq('abbyyR')
      expect(Package.last.version).to eq('0.3')
    end
  end

  context 'failure during persisting package to DB' do
    it 'will fail because package do not contain mandatory fields' do
      expect do
        described_class.perform_now('wrong input')
      end.to raise_error(ArgumentError, 'Package missing mandatory fields')
    end
  end
end
