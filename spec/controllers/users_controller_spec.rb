require 'rails_helper'

RSpec.describe UsersController do

  it 'renders the login page' do
    get :new
    expect(response).to render_template('new')
  end

  let(:expected_token) { 'ABCDEFGHIJKLMNOPQRSTUVXZ' }
  let(:env_auth) do
    {
      'credentials' => {
        'token' => expected_token
      }
    }
  end

  describe '#create' do
    before do
      request.env['omniauth.auth'] = env_auth
    end
    it 'sets a session token with auth credentials' do
      get :create
      expect(session[:token]).to eq expected_token
    end
  end

  describe '#destroy' do
    it 'purges all user cache' do
      session[:token] = expected_token
      expect(Rails.cache).to receive(:delete).with([expected_token, 'me'])
      expect(Rails.cache).to receive(:delete).with([expected_token, 'user_media'])
      expect(Rails.cache).to receive(:delete).with([expected_token, 'user_last_media'])

      get :destroy
    end
  end
end
