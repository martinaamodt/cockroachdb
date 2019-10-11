require 'spec_helper'

describe 'cockroachdb' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:pre_condition) { 'include stdlib' }

      it { is_expected.to compile }
      it { is_expected.to contain_file('/usr/local/bin/cockroach').with_mode('0755') }
    end
  end
end
