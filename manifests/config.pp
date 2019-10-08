# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include cockroachdb::config
class cockroachdb::config {
  $defaults = { 'path' => $cockroachdb::servicepath }
  $settings = {
    'Unit' => {
      'Description' => $cockroachdb::description,
      'Requires'    => 'network.target',
    },
    'Service' => {
      'Type'             => 'notify',
      'WorkingDirectory' => $cockroachdb::workingdirectory,
      'ExecStart'        => "/usr/local/bin/cockroach start --insecure --advertise-addr=${cockroachdb::node1ip} --join=${cockroachdb::node1ip},${cockroachdb::node2ip},${cockroachdb::node3ip} --cache=${cockroachdb::cache} --max-sql-memory=${cockroachdb::maxsqlmemory}",
      'TimeoutStopSec'   => $cockroachdb::timeoutstopsec,
      'Restart'          => $cockroachdb::restart,
      'RestartSec'       => $cockroachdb::restartsec,
      'StandardOutput'   => $cockroachdb::standardoutput,
      'StandardError'    => $cockroachdb::standarderror,
      'SyslogIdentifier' => $cockroachdb::syslogidentifier,
      'User'             => $cockroachdb::user,
    },
    'Install' => {
      'WantedBy' => 'default.target'
      },
    }
  create_ini_settings($settings, $defaults)
}
