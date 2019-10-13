# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include cockroachdb
class cockroachdb (
  # Would prefer to use Stdlib::absolutepath version. But it fails test with Puppet5
  #Stdlib::Absolutepath $servicepath,
  Optional[String] $servicepath              = $cockroachdb::params::servicepath,
  #Stdlib::Absolutepath $workingdirectory,
  Optional[String] $workingdirectory         = $cockroachdb::params::workingdirectory,
  # 
  Optional[Tuple] $dependencies              = $cockroachdb::params::dependencies,
  Optional[String] $description              = $cockroachdb::params::description,
  Optional[String] $cache                    = $cockroachdb::params::cache,
  Optional[String] $maxsqlmemory             = $cockroachdb::params::maxsqlmemory,
  Optional[String] $timeoutstopsec           = $cockroachdb::params::timeoutstopsec,
  Optional[String] $restart                  = $cockroachdb::params::restart,
  Optional[String] $restartsec               = $cockroachdb::params::restartsec,
  Optional[String] $standardoutput           = $cockroachdb::params::standardoutput,
  Optional[String] $standarderror            = $cockroachdb::params::standarderror,
  Optional[String] $syslogidentifier         = $cockroachdb::params::syslogidentifier,
  Optional[String] $user                     = $cockroachdb::params::user,
  String $node1ip                            = $cockroachdb::params::node1ip,
  String $node2ip                            = $cockroachdb::params::node2ip,
  String $node3ip                            = $cockroachdb::params::node3ip,

  #Archive
  Optional[String] $install_path             = $cockroachdb::params::install_path,
  Optional[String] $package_name             = $cockroachdb::params::package_name,
  String $package_ensure                     = $cockroachdb::params::package_ensure,
  Optional[String] $repository_url           = $cockroachdb::params::repository_url,
  Optional[String] $archive_name             = $cockroachdb::params::archive_name,
  Optional[String] $cockroach_archive_source = $cockroachdb::params::cockroachdb_package_source,

) inherits cockroachdb::params {
  contain cockroachdb::install
  contain cockroachdb::config
  Class['::cockroachdb::install'] -> Class['::cockroachdb::config']
}
