# frozen_string_literal: true

UNSUPPORTED_PLATFORMS = ['aix', 'windows', 'solaris', 'redhat'].freeze

def cockroachdb_version
  result = run_shell('cockroach version')
  result.stdout.match(%r{\s(v\d{1,2}\.\d\.\d)})[1]
end
