require 'rails_helper'

RSpec.describe UserFeedService do

  subject { UserFeedService.new(spec_fake_client) }

  it 'fetches media from client' do
    VCR.use_cassette('user_feed_service') do
      expect(spec_fake_client).to receive(:user_recent_media).twice.and_call_original
      subject.user_media
    end
  end

  it 'fetches all media' do
    VCR.use_cassette('user_feed_service') do
      expect(subject.user_media.size).to eq 40
    end
  end
end
