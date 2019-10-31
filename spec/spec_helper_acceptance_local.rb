# frozen_string_literal: true

UNSUPPORTED_PLATFORMS = ['aix', 'windows', 'solaris', 'redhat'].freeze

def cockroachdb_version
  result = run_shell('cockroach version')
  result.stdout.match(%r{\s(v\d{1,2}\.\d\.\d)})[1]
end

def cockroach(cockroach_cmd, user = 'cockroach', exit_codes = [0, 1], &block)
  cockroach = "cockroach #{cockroach_cmd}"
  run_shell("cd /tmp; su #{shellescape(user)} -c #{shellescape(cockroach)}", acceptable_exit_codes: exit_codes, &block)
end
