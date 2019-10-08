require 'spec_helper'

describe 'cockroachdb::install' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:pre_condition) { 'cockroachdb', }

      it { is_expected.to compile }
    end
  end
end
