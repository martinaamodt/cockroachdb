require 'spec_helper_acceptance'

describe 'cockroachdb class' do
  describe 'default settings' do
    let(:pp) do
      <<-MANIFEST
          class { 'cockroachdb':
            node1ip     => 'db0',
            node2ip     => 'db1',
            node3ip     => 'db2',
            secure_mode => false,
          }
      MANIFEST
    end

    it 'behaves idempotently' do
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    it 'executes' do
      expect(cockroachdb_version).to match('v19.1.5')
    end

    describe service('cockroachdb.service') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  end
end
