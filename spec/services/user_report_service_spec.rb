require 'rails_helper'

RSpec.describe UserReportService do

  let(:this_week) { (DateTime.current - 1.day).to_i }
  let(:last_week) { (DateTime.current - 9.days).to_i }
  let(:two_weeks_ago) { (DateTime.current - 16.days).to_i }

  let(:user_media) do
    [
      Instagram::Media.new({created_time: this_week, likes: {'count' => 15}, comments: {'count' => 10}}),
      Instagram::Media.new({created_time: this_week, likes: {'count' => 5}, comments: {'count' => 7}}),
      Instagram::Media.new({created_time: last_week, likes: {'count' => 15}, comments: {'count' => 10}}),
      Instagram::Media.new({created_time: two_weeks_ago, likes: {'count' => 25}, comments: {'count' => 20}})
    ]
  end

  subject { UserReportService.new(user_media) }

  it 'returns a report for the last two weeks' do
    expect(subject.report[:aggregate].size).to eq 2
  end

  it 'calculates variations' do
    expect(subject.report[:variations][:posts]).to eq 100
    expect(subject.report[:variations][:likes]).to eq 33
    expect(subject.report[:variations][:comments]).to eq 70
  end
end
