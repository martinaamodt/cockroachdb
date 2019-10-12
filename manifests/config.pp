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

  $insecurecockroachdb_hash = {
    'description'       => $cockroachdb::description,
    'workingdirectory'  => $cockroachdb::workingdirectory,
    'node1ip'           => $cockroachdb::node1ip,
    'node2ip'           => $cockroachdb::node2ip,
    'node3ip'           => $cockroachdb::node3ip,
    'cache'             => $cockroachdb::cache,
    'maxsqlmemory'      => $cockroachdb::maxsqlmemory,
    'timeoutstopsec'    => $cockroachdb::timeoutstopsec,
    'restart'           => $cockroachdb::restart,
    'restartsec'        => $cockroachdb::restartsec,
    'standardoutput'    => $cockroachdb::standardoutput,
    'standarderror'     => $cockroachdb::standarderror,
    'syslogidentifier'  => $cockroachdb::syslogidentifier,
    'user'              => $cockroachdb::user,
  }

  file { '/etc/systemd/system/insecurecockroachdb.service':
    ensure  => file,
    content => epp('cockroachdb/insecurecockroachdb.service.epp', $insecurecockroachdb_hash ),
    notify  => Service['insecurecockroachdb'],
  }

  service { 'insecurecockroachdb':
    ensure => 'running',
  }
}
