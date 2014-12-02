require 'rails_helper'

RSpec.describe UserFeedService do

  let(:client) { double(:client) }
  module Attrs
    attr_accessor :pagination
  end

  before do
    @user_recent_media = [
      double(:media, created_time: (DateTime.current - 1.day).to_i, to_hash: {}),
      double(:media, created_time: (DateTime.current - 6.week).to_i, to_hash: {})
    ]
    @user_recent_media.extend(Attrs)
    allow(@user_recent_media).to receive(:pagination)
      .and_return(double(:pagination, next_max_id: 10), double(:pagination, next_max_id: nil))
    allow(client).to receive(:user_recent_media) { @user_recent_media }
  end

  subject { UserFeedService.new(client) }

  it 'fetches media from client' do
    expect(client).to receive(:user_recent_media).twice
    subject.user_media
  end

  it 'filters media out of the range' do
    expect(subject.user_media.size).to eq 2
  end
end
