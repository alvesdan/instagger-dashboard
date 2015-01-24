require 'rails_helper'

RSpec.describe DashboardController do

  before do
    authenticate_with_spec_token!
  end

  describe 'view rendering disabled' do
    around(:example) do |example|
      VCR.use_cassette('user_feed_service') do
        example.run
      end
    end

    it 'renders the statistics page' do
      get :show
      expect(response).to render_template('show')
    end
  end

  describe 'with view rendering enabled' do
    render_views

    around(:example) do |example|
      VCR.use_cassette('complete') do
        example.run
      end
    end

    it 'displays report page for user' do
      get :show
      expect(response.body).to match(/alvesdan/)
    end
  end

  context 'with unauthorized user' do
    before do
      allow(subject).to receive(:user_signed_in?)
        .and_raise(Instagram::BadRequest)
    end

    it 'destroys user session' do
      get :show
      expect(response).to redirect_to('/sign-out')
    end
  end
end
