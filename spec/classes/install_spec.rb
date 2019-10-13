require 'spec_helper'

describe 'cockroachdb::install' do
  let(:params) do
    {
      cockroachdb::install_path => '/usr/local/bin',
      cockroachdb::package_ensure => 'v19.1.5.linux-amd64',
      cockroachdb::node1ip => 'db0',
      cockroachdb::node2ip => 'db1',
      cockroachdb::node3ip => 'db2',
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
      # it { is_expected.to contain_package('tar') }
      # it { is_expected.to contain_package('wget') }
    end
  end
end
