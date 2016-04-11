RSpec.describe PackagesHelper do
  describe '#package_index_columns' do
    it 'render columns for table where we list packages' do
      expect(helper.package_index_columns).to eq(
        %w(package_name version publication title)
      )
    end
  end
end