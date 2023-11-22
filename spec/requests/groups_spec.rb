require 'rails_helper'

RSpec.describe 'Groups', type: :request do
  let(:valid_attributes) { { 'user' => @user, 'name' => 'Food', 'icon' => 'missing_avatar.png' } }

  before :each do
    @user = User.create(name: 'Tom', email: 'tom@example.com', password: 'topsecret')
    @user.confirm
    login(@user)
  end

  context 'GET /create' do
    it 'returns http redirect response' do
      post groups_path, params: { group: valid_attributes }
      expect(response.status).to eq(302)
    end

    it 'creates a group' do
      expect { post groups_path, params: { group: valid_attributes } }.to change(Group, :count).by(1)
    end

    it 'redirects to a page' do
      post groups_path, params: { group: valid_attributes }
      expect(response).to redirect_to groups_path
    end
  end

  context 'GET /index' do
    before :each do
      get groups_path
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the right view file' do
      expect(response).to render_template(:index)
    end

    it 'renders the right placeholder' do
      expect(response.body).to include('<h1>categories</h1>')
    end
  end

  context 'GET /new' do
    before :each do
      get new_group_path
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the right view file' do
      expect(response).to render_template(:new)
    end

    it 'renders the right placeholder' do
      expect(response.body).to include('<h1>new category</h1>')
    end
  end

  context 'GET /edit' do
    let(:group) { Group.create! valid_attributes }

    before :each do
      get edit_group_url(group)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the right view file' do
      expect(response).to render_template(:edit)
    end

    it 'renders the right placeholder' do
      expect(response.body).to include('<h1>edit category</h1>')
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
