require 'rails_helper'

RSpec.describe PackagesController do

  describe 'GET #index' do
    it 'returns http success' do
      get :index

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end

    it 'assigns @packages' do
      package = create(:package, status: :active)

      get :index

      expect(assigns(:packages)).to eq([package])
    end
  end

end
