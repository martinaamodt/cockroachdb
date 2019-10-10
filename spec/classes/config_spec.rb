require 'spec_helper'

describe 'cockroachdb::config' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:pre_condition) { 'include cockroachdb' }

      it { is_expected.to compile }
      it { is_expected.to contain_file('/usr/local/bin/cockroach').with_mode('0755') }
      it { is_expected.to contain_file('/var/lib/cockroach').without_mode }
    end
  end
end
