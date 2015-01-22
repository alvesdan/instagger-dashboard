require 'rails_helper'

RSpec.describe UserFeedService do

  let(:this_week) { (DateTime.current - 1.day).to_i }
  let(:last_week) { (DateTime.current - 3.week).to_i }
  let(:older) { (DateTime.current - 6.week).to_i }

  let(:client) { double(:client) }
  module Attrs
    attr_accessor :pagination
  end

  before do
    @user_recent_media_page_1 = [
      double(:media, created_time: this_week, to_hash: { created_time: this_week }),
      double(:media, created_time: last_week, to_hash: { created_time: last_week })
    ]
    @user_recent_media_page_2 = [
      double(:media, created_time: older, to_hash: { created_time: older })
    ]

    @user_recent_media_page_1.extend(Attrs)
    @user_recent_media_page_2.extend(Attrs)

    allow(@user_recent_media_page_1).to receive(:pagination)
      .and_return(double(:pagination, next_max_id: 10))
    allow(@user_recent_media_page_2).to receive(:pagination)
      .and_return(double(:pagination, next_max_id: nil))

    allow(client).to receive(:user_recent_media)
      .and_return(@user_recent_media_page_1, @user_recent_media_page_2)
  end

  subject { UserFeedService.new(client) }

  it 'fetches media from client' do
    expect(client).to receive(:user_recent_media).twice
    subject.user_media
  end

  it 'fetches all media' do
    expect(subject.user_media.size).to eq 3
  end
end
