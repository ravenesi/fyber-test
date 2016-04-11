RSpec.describe "packages/index.html.erb" do
  it "test if packages are blank" do
    assign(:packages, [])

    render

    expect(response.body).to include("No packages indexed.")
  end
end
