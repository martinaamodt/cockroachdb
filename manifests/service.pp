# == Class cockroach::service
#
# This class is called from the cockroachdb class to configure the service.
#
#
class cockroachdb::service {

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
    'region'            => $cockroachdb::region,
    'datacenter'        => $cockroachdb::datacenter,
    'zone'              => $cockroachdb::zone,
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