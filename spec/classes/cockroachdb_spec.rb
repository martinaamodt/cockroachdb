require 'spec_helper'

describe 'cockroachdb' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:params) do
        {
          'node1ip' => 'db0',
          'node2ip' => 'db1',
          'node3ip' => 'db2',
          'secure_mode' => false,
        }
      end
      let(:facts) { os_facts }
      let(:pre_condition) { 'include stdlib' }

      it { is_expected.to compile }
      it { is_expected.to contain_file('/usr/local/bin/cockroach').with_mode('0755') }
      it { is_expected.to contain_file('/var/lib/cockroach').with('owner' => 'cockroach') }
      it { is_expected.to contain_service('cockroachdb').with(ensure: 'running') }
      it { is_expected.to contain_package('tar') }
      it { is_expected.to contain_package('wget') }
    end
  end
end
