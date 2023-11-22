require 'rails_helper'

RSpec.describe "Pages", type: :request do
  before :each do
    user = User.create(name: 'Tom', email: 'tom@example.com', password: 'topsecret')
    user.confirm
    login(user)
  end

  context "GET /splash" do
    before :each do
      get "/pages/splash"
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'renders the right view file' do
      expect(response).to render_template(:splash)
    end

    it 'renders the right placeholder' do
      expect(response.body).to include('<h1>SmartPocket</h1>')
    end
  end

  context "GET /about" do
    before :each do
      get "/pages/about"
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'renders the right view file' do
      expect(response).to render_template(:about)
    end

    it 'renders the right placeholder' do
      expect(response.body).to include('<h1>about</h1>')
    end
  end

  def login(user)
    post new_user_session_path, params: {
      user: {
        email: user.email, password: user.password
      }
    }
    follow_redirect!
  end
end
