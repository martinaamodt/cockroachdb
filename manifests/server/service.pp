#
#
# @summary
#   This class is called from the cockroachdb class to configure the service.
#
#
class cockroachdb::server::service {

  $cockroachdb_hash = {
    'install_path'     => $cockroachdb::server::install_path,
    'package_name'     => $cockroachdb::server::package_name,
    'description'      => $cockroachdb::server::description,
    'workingdirectory' => $cockroachdb::server::workingdirectory,
    'node1ip'          => $cockroachdb::server::node1ip,
    'node2ip'          => $cockroachdb::server::node2ip,
    'node3ip'          => $cockroachdb::server::node3ip,
    'cache'            => $cockroachdb::server::cache,
    'maxsqlmemory'     => $cockroachdb::server::maxsqlmemory,
    'timeoutstopsec'   => $cockroachdb::server::timeoutstopsec,
    'restart'          => $cockroachdb::server::restart,
    'restartsec'       => $cockroachdb::server::restartsec,
    'standardoutput'   => $cockroachdb::server::standardoutput,
    'standarderror'    => $cockroachdb::server::standarderror,
    'syslogidentifier' => $cockroachdb::server::syslogidentifier,
    'user'             => $cockroachdb::server::user,
    'additionalparams' => $cockroachdb::server::additional_params,
    'locality'         => $cockroachdb::server::locality,
    'secure_mode'      => $cockroachdb::server::secure_mode,
    'certs_dir'        => $cockroachdb::server::certs_dir,
    'dns_mode'         => $cockroachdb::server::params::dns_mode,
    'dns_mode_custom'  => $cockroachdb::server::params::dns_mode_custom,
  }

  file { "${cockroachdb::server::servicepath}/cockroachdb.service":
    ensure  => file,
    content => epp('cockroachdb/cockroachdb.service.epp', $cockroachdb_hash),
    notify  => Service['cockroachdb'],
  }
  service { 'cockroachdb':
    ensure => 'running',
  }
}