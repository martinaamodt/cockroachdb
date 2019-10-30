require 'spec_helper'

describe 'cockroachdb', type: :class do
  let(:params) do
    {
      node1ip: 'db0',
      node2ip: 'db1',
      node3ip: 'db2',
      secure_mode: false,
    }
  end
  let(:node) { 'db1' }

  on_supported_os.each do |os, os_facts|
    let(:facts) { os_facts }

    context "on #{os} with default settings, secure mode off" do
      it { is_expected.to compile }
      # Verify that executable is installed
      it { is_expected.to contain_file('/usr/local/bin/cockroach').with(mode: '0755') }
      # Default data directory
      it { is_expected.to contain_file('/var/lib/cockroach').with(owner: 'cockroach') }
      # Verify that secure mode is off
      it { is_expected.to contain_file('/etc/systemd/system/cockroachdb.service').with_content(%r{--insecure}) }
      # Verify that hostname is inserted into service template
      it { is_expected.to contain_file('/etc/systemd/system/cockroachdb.service').with_content(%r{--advertise-addr=db1}) }
      it { is_expected.to contain_service('cockroachdb').with(ensure: 'running', enable: true) }

      it { is_expected.to contain_package('tar') }
      it { is_expected.to contain_package('wget') }
    end

    context "on #{os} with default settings, secure mode on" do
      let(:params) do
        super().merge(secure_mode: true, certs_dir: '/root/certs')
      end

      it { is_expected.to contain_file('/etc/systemd/system/cockroachdb.service').with_content(%r{--certs-dir=/root/certs}) }
    end

    context "on #{os} with different version of cockroach and install path" do
      let(:params) do
        super().merge(package_ensure: 'v19.1.1.linux-amd64', install_path: '/root')
      end

      it { is_expected.to contain_file('/root/cockroach').with(mode: '0755') }
    end

    context "on #{os} single node with default settings, secure mode off" do
      let(:params) do
        {
          node1ip: 'localhost',
          secure_mode: false,
        }
      end

      # Verify that secure mode is off
      it { is_expected.to contain_file('/etc/systemd/system/cockroachdb.service').with_content(%r{--insecure}) }
      # Verify that hostname is inserted into service template
      it { is_expected.to contain_file('/etc/systemd/system/cockroachdb.service').with_content(%r{--listen-addr=localhost}) }
      it { is_expected.to contain_service('cockroachdb').with(ensure: 'running', enable: true) }
    end
  end
end
