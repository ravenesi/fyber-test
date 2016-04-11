RSpec.describe ApplicationHelper do
  describe '#title' do
    it 'render h1' do
      @page_title = 'test'

      expect(helper.title).to eq(
        '<h1>test</h1>'
      )
    end
  end
end