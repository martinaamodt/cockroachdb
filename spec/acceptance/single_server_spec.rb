require 'spec_helper_acceptance'

describe 'cockroachdb class' do
  describe 'default settings, secure mode off, single server mode' do
    let(:pp) do
      <<-MANIFEST
          class { 'cockroachdb':
            node1ip     => 'localhost',
            secure_mode => false,
          }
      MANIFEST
    end

    it 'behaves idempotently' do
      idempotent_apply(pp)
    end

    it 'executes' do
      expect(cockroachdb_version).to match('v19.1.5')
    end

    describe file('/etc/systemd/system/cockroachdb.service') do
      its(:content) { is_expected.to match %r{--listen-addr=localhost} }
    end

    describe service('cockroachdb.service') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  end

  describe 'default settings, secure mode off, multi server mode' do
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
      idempotent_apply(pp)
    end

    it 'executes' do
      expect(cockroachdb_version).to match('v19.1.5')
    end

    describe file('/etc/systemd/system/cockroachdb.service') do
      its(:content) { is_expected.to match %r{--join=db0,db1,db2} }
    end

    describe service('cockroachdb.service') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  end
end
