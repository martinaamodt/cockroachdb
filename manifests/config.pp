# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include cockroachdb::config
class cockroachdb::config {
  $defaults = { 'path' => '/etc/systemd/system/insecurecocroachdb.service' }
  $settings = {
    'Unit' => {
      'Description' => 'Cockroach Database cluster node',
      'Requires'    => 'network.target',
    },
    'Service' => {
      'Type'             => 'notify',
      'WorkingDirectory' => '/var/lib/cockroach',
      'ExecStart'        => '/usr/local/bin/cockroach start --insecure --advertise-addr=<node1 address> --join=<node1 address>,<node2 address>,<node3 address> --cache=.25 --max-sql-memory=.25',
      'TimeoutStopSec'   => '60',
      'Restart'          => 'always',
      'RestartSec'       => '10',
      'StandardOutput'   => 'syslog',
      'StandardError'    => 'syslog',
      'SyslogIdentifier' => 'cockroach',
      'User'             => 'cockroach',
    },
    'Install' => {
      'WantedBy' => 'default.target'
      },
    }
  create_ini_settings($settings, $defaults)
}
