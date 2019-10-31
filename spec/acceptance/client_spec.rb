require 'spec_helper_acceptance'

describe 'cockroachdb::client class' do
  describe 'default settings' do
    let(:pp) do
      <<-MANIFEST
          include cockroachdb::client
      MANIFEST
    end

    it 'behaves idempotently' do
      idempotent_apply(pp)
    end

    it 'executes' do
      expect(cockroachdb_version).to match('v19.1.5')
    end
  end
end
