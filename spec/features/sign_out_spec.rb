require 'rails_helper'

feature 'sign out' do

  scenario 'Log out signed in user' do
    VCR.use_cassette('complete') do
      page.set_rack_session(token: spec_token)
      visit '/'
      expect(page).to have_content('alvesdan')
      click_link 'Log Out'
      expect(page).to have_content('weekly dose')
    end
  end
end
