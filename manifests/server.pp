# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include cockroachdb::server
class cockroachdb::server (
  Optional[Stdlib::Absolutepath] $servicepath                         = $cockroachdb::params::servicepath,
  Optional[Stdlib::Absolutepath] $workingdirectory                    = $cockroachdb::params::workingdirectory,
  Optional[Tuple] $dependencies                                       = $cockroachdb::params::dependencies,
  Optional[String] $description                                       = $cockroachdb::params::description,
  Optional[String] $cache                                             = $cockroachdb::params::cache,
  Optional[String] $maxsqlmemory                                      = $cockroachdb::params::maxsqlmemory,
  Optional[String] $timeoutstopsec                                    = $cockroachdb::params::timeoutstopsec,
  Optional[String] $restart                                           = $cockroachdb::params::restart,
  Optional[String] $restartsec                                        = $cockroachdb::params::restartsec,
  Optional[String] $standardoutput                                    = $cockroachdb::params::standardoutput,
  Optional[String] $standarderror                                     = $cockroachdb::params::standarderror,
  Optional[String] $syslogidentifier                                  = $cockroachdb::params::syslogidentifier,
  Optional[String] $user                                              = $cockroachdb::params::user,
  String $node1ip                                                     = $cockroachdb::params::node1ip,
  String $node2ip                                                     = $cockroachdb::params::node2ip,
  String $node3ip                                                     = $cockroachdb::params::node3ip,
  Optional[String] $additional_params                                 = $cockroachdb::params::additional_params,
  Boolean $secure_mode                                                = $cockroachdb::params::secure_mode,
  Optional[Array[String, 1]] $locality                                = $cockroachdb::params::locality,
  Optional[Stdlib::Absolutepath] $certs_dir                           = $cockroachdb::params::certs_dir,
  Optional[Enum['hostname', 'fqdn', 'ipaddress', 'custom']] $dns_mode = $cockroachdb::params::dns_mode,
  Optional[String] $dns_mode_custom                                   = $cockroachdb::params::dns_mode_custom,
  #Archive
  Optional[Stdlib::Absolutepath] $install_path                        = $cockroachdb::params::install_path,
  Optional[String] $package_name                                      = $cockroachdb::params::package_name,
  String $package_ensure                                              = $cockroachdb::params::package_ensure,
  Optional[String] $repository_url                                    = $cockroachdb::params::repository_url,
  Optional[String] $archive_name                                      = $cockroachdb::params::archive_name,
  Optional[String] $cockroach_archive_source                          = $cockroachdb::params::cockroachdb_package_source,
) inherits cockroachdb::params {
  contain cockroachdb::install
  contain cockroachdb::config
  contain cockroachdb::service

  Class['::cockroachdb::install']
  -> Class['::cockroachdb::config']
  -> Class['::cockroachdb::service']
}
