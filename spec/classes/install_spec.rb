require 'spec_helper'

describe 'cockroachdb::install' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:pre_condition) { 'include cockroachdb' }

      it { is_expected.to compile }
      it { is_expected.to contain_package('tar') }
      it { is_expected.to contain_package('wget') }
    
    end
  end
end
