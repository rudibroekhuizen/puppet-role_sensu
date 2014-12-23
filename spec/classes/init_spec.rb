require 'spec_helper'
describe 'role_sensu' do

  context 'with defaults for all parameters' do
    it { should contain_class('role_sensu') }
  end
end
