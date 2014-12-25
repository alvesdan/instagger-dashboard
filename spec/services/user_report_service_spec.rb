require 'rails_helper'

RSpec.describe UserReportService do

  let(:this_week) { (DateTime.current - 1.day).to_i }
  let(:last_week) { (DateTime.current - 1.week).to_i }

  let(:user_media) do
    [
      Instagram::Media.new({created_time: last_week, likes: {'count' => 10}, comments: {'count' => 5}}),
      Instagram::Media.new({created_time: this_week, likes: {'count' => 15}, comments: {'count' => 10}})
    ]
  end

  subject { UserReportService.new(user_media) }

  it 'returns a report grouped by week' do
    expect(subject.report.size).to eq 1
    expect(subject.report.first[:aggregate].size).to eq 2
  end

  it 'calculates variations' do
    expect(subject.report.first[:variations][:posts]).to eq 0
    expect(subject.report.first[:variations][:likes]).to eq 50
    expect(subject.report.first[:variations][:comments]).to eq 100
  end
end
