#
#
# @summary
#   Installs cockroachdb as a service to run a server using the cockroach::install, cockroachdb::service
#   and cockroach::config classes.
#
#
#
# @param servicepath
#   Location of where the ".service" file is to be saved.
#   If the parameter is not defined it will be saved in "/etc/systemd/system".
#
# @param workingdirectory
#   Location of where the working directory will be created.
#   If the parameter is not defined it will be created in "/var/lib/cockroach".
#
# @param dependencies
#   Consists of dependencies 'tar' and 'wget' by default. Failing to include these dependencies while defining
#   this parameter yourself may result in dependency issues.
#
# @param description
#   Cockroachdb node description.
#
# @param cache
#   The total size for caches, shared if there are multiple storage devices, noted with a
#   decimal or '%'.
#
# @param maxsqlmemory
#   The maximum in-memory storage capaciy available to store temprary data for SQL queries.
#   Noted with a decimal point or '%'.
#
# @param timeoutstopsec
#   Configures the time to wait for each ExecStop command for systemd.
#
# @param restart
#   Defines when the service is to be restarted. Configured with always by default
#   and will restart on every restart setting and exit cause.
#
# @param restartsec
#   Defines the time to sleep before restarting the service.
#
# @param standardoutput
#   Controls where the file descriptor 1 (STDOUT) of the executed processes is connected to.
#
# @param standarderror
#    Controls where the file descriptor 2 (STDERR) of the executed process is connected to.
#
# @param syslogidentifier
#   Sets the process name ("syslog tag") to prefix log lines sent to the logging system
#   or the kernel log buffer.
#
# @param user
#   Sets the user/group that the processes are executed as.
#
# @param node1ip
#   Sets the ip-address for node one.
#
# @param node2ip
#   Sets the ip-address for node two.
#
# @param node3ip
#   Sets the ip-address for node three.
#
# @param install_path
#   Location where the program binary file is to be located.
#
# @param package_name
#   Name of the package to install.
#
# @param package_ensure
#   Version number and linux distribution name.
#
# @param repository_url
#   Base repository URL.
#
# @param archive_name
#   Archive path of the binary file in the base repository.
#
# @param cockroach_archive_source
#   Full binary package source.
#
# @param additional_params
#   Additional params and flags to pass to cockroachdb on startup. Must be provided as fully valid cockroachdb flags.
#
# @param secure_mode
#   If cockroachdb secure mode is enabled or not. Currently only supports insecure mode.
#
# @param locality
#   Array of Hashes containing locality information for nodes.
#
# @param certs_dir
#   The directory where CockroachDB can find certificates.
# @param dns_mode
#   Use FQDN, hostnames, IPs or custom facts to identify nodes.
# @param dns_mode_custom
#   Custom fact used to identify nodes. Can be any valid facter fact, like custom facts.
#
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
  Optional[String] $cockroach_archive_source                          = $cockroachdb::params::cockroachdb_package_source
  ,

) inherits cockroachdb::params {
  contain cockroachdb::server::install
  contain cockroachdb::server::config
  contain cockroachdb::server::service

  Class['::cockroachdb::server::install']
  -> Class['::cockroachdb::server::config']
  -> Class['::cockroachdb::server::service']
}
