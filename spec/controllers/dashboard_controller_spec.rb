require 'rails_helper'

RSpec.describe DashboardController do

  around(:example) do |example|
    VCR.use_cassette('user_feed_service') do
      example.run
    end
  end

  before do
    authenticate_with_spec_token!
  end

  it 'renders the statistics page' do
    get :show
    expect(response).to render_template('show')
  end
end
