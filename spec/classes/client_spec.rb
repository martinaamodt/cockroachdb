require 'spec_helper'

describe 'cockroachdb::client', type: :class do
  on_supported_os.each do |os, os_facts|
    context "on #{os} with default settings" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
      # Verify that executable is installed
      it { is_expected.to contain_file('/usr/local/bin/cockroach').with(mode: '0755') }

      it { is_expected.to contain_package('tar') }
      it { is_expected.to contain_package('wget') }
    end
  end
end