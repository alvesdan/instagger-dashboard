require 'rails_helper'

RSpec.describe UserReportServiceDecorator do

  let(:this_week) { (DateTime.current - 1.day).to_i }
  let(:last_week) { (DateTime.current - 9.days).to_i }
  let(:user_media) do
    [
      Instagram::Media.new({created_time: this_week, likes: {'count' => 2}, comments: {'count' => 10}}),
      Instagram::Media.new({created_time: last_week, likes: {'count' => 15}, comments: {'count' => 5}})
    ]
  end

  let(:report) do
    UserReportService.new(user_media)
  end
  subject { described_class.new(report) }

  describe '#icon_for' do
    it 'returns an icon for a variation' do
      expect(subject.icon_for(:posts)).to eq 'minus'
      expect(subject.icon_for(:likes)).to eq 'chevron-down'
      expect(subject.icon_for(:comments)).to eq 'chevron-up'
    end
  end
end
