require 'spec_helper'
describe 'pe_slack_bot', type: :class do
  describe 'without parameters' do
    it { is_expected.not_to compile }
  end
end
