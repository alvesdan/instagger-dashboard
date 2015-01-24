require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  describe '#fancy_pluralize' do
    it 'returns a fancy version of pluralize' do
      expect(helper.fancy_pluralize(1, 'like')).to eq '<span class="count">1</span> <span class="counted">like</span>'
      expect(helper.fancy_pluralize(2, 'like')).to eq '<span class="count">2</span> <span class="counted">likes</span>'
    end
  end

  describe '#icon_tag' do
    it 'returns an Bootstrap glyphicon span' do
      expect(helper.icon_tag('plus')).to eq '<span class="glyphicon glyphicon-plus"></span>'
    end
  end
end
