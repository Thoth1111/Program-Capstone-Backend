require 'devise'
require 'rails_helper'

RSpec.describe VespasController, type: :controller do
  include Devise::Test::ControllerHelpers

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @user = User.create(id: 1, username: 'user1', email: 'user1@test.com', password: 'password', password_confirmation: 'password', jti: 'user_token')
    request.headers['Authorization'] = @user.jti
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new vespa' do
        post :create, params: { vespa: { name: 'Soba 1', icon: 'icon.png', description: 'description1', cost_per_day: 100.0 } }
        expect(Vespa.count).to eq(1)
      end

      it 'returns a successful response' do
        post :create, params: { vespa: { name: 'Soba 1', icon: 'icon.png', description: 'description1', cost_per_day: 100.0 } }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new vespa' do
        post :create, params: { vespa: { name: '', icon: 'icon.png', description: 'description1', cost_per_day: 100.0 } }
        expect(Vespa.count).to eq(0)
      end

      it 'returns an error response' do
        post :create, params: { vespa: { name: '', icon: 'icon.png', description: 'description1', cost_per_day: 100.0 } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #index' do
    before do
      post :create, params: { vespa: { name: 'Soba 1', icon: 'icon.png', description: 'description1', cost_per_day: 100.0 } }
      @vespa = Vespa.last
    end

    it 'returns all vespas' do
      get :index
      actual_response = JSON.parse(response.body)
      actual_response.each { |vespa| vespa.delete('comments_count') }
      expect(actual_response.to_json).to eq([@vespa].to_json)
    end
  end

  describe 'DELETE #destroy' do
    before do
      post :create, params: { vespa: { name: 'Soba 1', icon: 'icon.png', description: 'description1', cost_per_day: 100.0 } }
      @vespa = Vespa.last
    end

    it 'destroys the vespa' do
      delete :destroy, params: { id: @vespa.id }
      expect(Vespa.count).to eq(0)
    end

    it 'returns a successful response' do
      delete :destroy, params: { id: @vespa.id }
      expect(response).to have_http_status(:ok)
    end
  end
end
