require 'rails_helper'

RSpec.describe UserReportService do

  let(:this_week) { (DateTime.current - 1.day).to_i }
  let(:last_week) { (DateTime.current - 1.week).to_i }
  let(:two_weeks_ago) { (DateTime.current - 2.weeks).to_i }

  let(:user_media) do
    [
      Instagram::Media.new({created_time: two_weeks_ago, likes: {'count' => 20}, comments: {'count' => 30}}),
      Instagram::Media.new({created_time: last_week, likes: {'count' => 10}, comments: {'count' => 10}}),
      Instagram::Media.new({created_time: this_week, likes: {'count' => 15}, comments: {'count' => 10}})
    ]
  end

  subject { UserReportService.new(user_media) }

  it 'returns a report grouped by week' do
    expect(subject.report.size).to eq 2
    expect(subject.report.first[:aggregate].size).to eq 2
  end

  it 'calculates variations' do
    expect(subject.report.first[:variations][:posts]).to eq 0
    expect(subject.report.first[:variations][:likes]).to eq (-50)
    expect(subject.report.first[:variations][:comments]).to eq (-67)
  end
end
