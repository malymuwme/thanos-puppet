require 'spec_helper'
describe 'thanos' do
  context 'with default values for all parameters' do
    it { should contain_class('thanos') }
  end
end
