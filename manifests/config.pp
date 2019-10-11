# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include cockroachdb::config
class cockroachdb::config {

  file { '/home/cockroach':
    ensure => directory,
    before => User['cockroach']
  }

  user { 'cockroach':
    ensure => present,
    home   => '/home/cockroach',
    shell  => '/bin/bash',
  }

  file { '/var/lib/cockroach':
    ensure  => directory,
    owner   => 'cockroach',
    require => User['cockroach'],
  }

  $defaults = { 'path' => "${cockroachdb::servicepath}/insecurecockroachdb.service" }
  $settings = {
    'Unit'    => {
      'Description' => $cockroachdb::description,
      'Requires'    => 'network.target',
    },
    'Service' => {
      'Type'             => 'notify',
      'WorkingDirectory' => $cockroachdb::workingdirectory,
      'ExecStart'        => "/usr/local/bin/cockroach start --insecure --advertise-addr=${::ipaddress} --join= \
        ${cockroachdb::node1ip},${cockroachdb::node2ip},${cockroachdb::node3ip} --cache=${cockroachdb::cache} \
         --max-sql-memory=${cockroachdb::maxsqlmemory}",
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

  service { 'insecurecockroachdb':
    ensure => 'running',
  }
}
