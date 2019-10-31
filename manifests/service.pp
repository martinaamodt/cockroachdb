#
#
# @summary
#   This class is called from the cockroachdb class to configure the service.
#
#
class cockroachdb::service {

  $cockroachdb_base_hash = {
    'install_path'     => $cockroachdb::install_path,
    'package_name'     => $cockroachdb::package_name,
    'description'      => $cockroachdb::description,
    'workingdirectory' => $cockroachdb::workingdirectory,
    'node1ip'          => $cockroachdb::node1ip,
    'cache'            => $cockroachdb::cache,
    'maxsqlmemory'     => $cockroachdb::maxsqlmemory,
    'timeoutstopsec'   => $cockroachdb::timeoutstopsec,
    'restart'          => $cockroachdb::restart,
    'restartsec'       => $cockroachdb::restartsec,
    'standardoutput'   => $cockroachdb::standardoutput,
    'standarderror'    => $cockroachdb::standarderror,
    'syslogidentifier' => $cockroachdb::syslogidentifier,
    'user'             => $cockroachdb::user,
    'additionalparams' => $cockroachdb::additional_params,
    'secure_mode'      => $cockroachdb::secure_mode,
    'certs_dir'        => $cockroachdb::certs_dir,
  }

  if $cockroachdb::node1ip != undef and $cockroachdb::node2ip == undef and $cockroachdb::node3ip == undef {
    file { "${cockroachdb::servicepath}/cockroachdb.service":
      ensure  => file,
      content => epp('cockroachdb/single_cockroachdb.service.epp', $cockroachdb_base_hash),
      notify  => Service['cockroachdb'],
    }
  } elsif $cockroachdb::node1ip != undef and $cockroachdb::node2ip != undef and $cockroachdb::node3ip != undef {
    $cockroachdb_multi_hash = {
      'node2ip'         => $cockroachdb::node2ip,
      'node3ip'         => $cockroachdb::node3ip,
      'locality'        => $cockroachdb::locality,
      'dns_mode'        => $cockroachdb::dns_mode,
      'dns_mode_custom' => $cockroachdb::dns_mode_custom,
    }

    file { "${cockroachdb::servicepath}/cockroachdb.service":
      ensure  => file,
      content => epp('cockroachdb/cockroachdb.service.epp', merge($cockroachdb_base_hash, $cockroachdb_multi_hash)),
      notify  => Service['cockroachdb'],
    }
  } else {
    fail('Node IPs not specified or specified correctly')
  }

  service { 'cockroachdb':
    ensure => 'running',
    enable => true,
  }
}
