RSpec.describe Package do
  it do
    is_expected.to validate_presence_of(:package_name).
      with_message("can't be blank")
  end

  it do
    is_expected.to validate_presence_of(:version).
      with_message("can't be blank")
  end

  context '#processed' do
    it 'will list just package who are already processed' do
      package = create(:package, status: :processing)

      expect(Package.processed.count).to be(0)

      package = create(:package, status: :active)

      expect(Package.processed.count).to be(1)
    end
  end
end
