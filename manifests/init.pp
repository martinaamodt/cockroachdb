# == Class: cockroachdb
#
# Recives parameters from the user and initializes the cockroach::install and cockroach::config
# classes.
#
# === Paramaters
#
# [servicepath]
#   Location of where the ".service" file is to be saved.
#   If the parameter is not defined it will be saved in "/etc/systemd/system".
# [workingdirectory]
#   Location of where the working directory will be created.
#   If the parameter is not defined it will be created in "/var/lib/cockroach".
# [dependencies]
#   Consists of dependencies 'tar' and 'wget' by default. Failing to include these dependencies while defining
#   this parameter yourself may result in dependency issues.
# [description]
#   Cockroachdb node description.
# [cache]
#   The total size for caches, shared if there are multiple storage devices, noted with a
#   decimal or '%'.
# [maxsqlmemory]
#   The maximum in-memory storage capaciy available to store temprary data for SQL queries.
#   Noted with a decimal point or '%'.
# [timeoutstopsec]
#   Configures the time to wait for each ExecStop command for systemd.
# [restart]
#   Defines when the service is to be restarted. Configured with always by default
#   and will restart on every restart setting and exit cause.
# [restartsec]
#   Defines the time to sleep before restarting the service.
# [standardoutput]
#   Controls where the file descriptor 1 (STDOUT) of the executed processes is connected to.
# [standarderror]
#    Controls where the file descriptor 2 (STDERR) of the executed process is connected to.
# [syslogidentifier]
#   Sets the process name ("syslog tag") to prefix log lines sent to the logging system
#   or the kernel log buffer.
# [user]
#   Sets the user/group that the processes are executed as.
# [region]
#   Sets the region of where the cluster is located.
#   Region is set to "undef" by default.
# [datacenter]
#   Sets the datacenter of where the cluster is located.
#   Datacenter is set to "undef" by default.
# [zone]
#   Sets the zone of where the cluster is located.
#   Zone is set to "undef" by default.
# [node1ip]
#   Sets the ip-address for node one.
# [node2ip]
#   Sets the ip-address for node two.
# [node3ip]
#   Sets the ip-address for node three.
# [install_path]
#   Location where the program binary file is to be located.
# [package_name]
#   Name of the package to install
# [package_ensure]
#   Version number and linux distribution name.
# [repository_url]
#   Base repository URL.
# [archive_name]
#   Archive path of the binary file in the base repository.
# [cockroach_archive_source]
#   Full binary package source.
#
class cockroachdb (
  Optional[Stdlib::Absolutepath] $servicepath      = $cockroachdb::params::servicepath,
  Optional[Stdlib::Absolutepath] $workingdirectory = $cockroachdb::params::workingdirectory,
  Optional[Tuple] $dependencies                    = $cockroachdb::params::dependencies,
  Optional[String] $description                    = $cockroachdb::params::description,
  Optional[String] $cache                          = $cockroachdb::params::cache,
  Optional[String] $maxsqlmemory                   = $cockroachdb::params::maxsqlmemory,
  Optional[String] $timeoutstopsec                 = $cockroachdb::params::timeoutstopsec,
  Optional[String] $restart                        = $cockroachdb::params::restart,
  Optional[String] $restartsec                     = $cockroachdb::params::restartsec,
  Optional[String] $standardoutput                 = $cockroachdb::params::standardoutput,
  Optional[String] $standarderror                  = $cockroachdb::params::standarderror,
  Optional[String] $syslogidentifier               = $cockroachdb::params::syslogidentifier,
  Optional[String] $user                           = $cockroachdb::params::user,
  Optional[String] $region                         = $cockroachdb::params::region,
  Optional[String] $datacenter                     = $cockroachdb::params::datacenter,
  Optional[String] $zone                           = $cockroachdb::params::zone,
  String $node1ip                                  = $cockroachdb::params::node1ip,
  String $node2ip                                  = $cockroachdb::params::node2ip,
  String $node3ip                                  = $cockroachdb::params::node3ip,


  #Archive
  Optional[Stdlib::Absolutepath] $install_path     = $cockroachdb::params::install_path,
  Optional[String] $package_name                   = $cockroachdb::params::package_name,
  String $package_ensure                           = $cockroachdb::params::package_ensure,
  Optional[String] $repository_url                 = $cockroachdb::params::repository_url,
  Optional[String] $archive_name                   = $cockroachdb::params::archive_name,
  Optional[String] $cockroach_archive_source       = $cockroachdb::params::cockroachdb_package_source,

) inherits cockroachdb::params {
  contain cockroachdb::install
  contain cockroachdb::config
  contain cockroachdb::service
  Class['::cockroachdb::install'] -> Class['::cockroachdb::config'] -> Class['::cockroachdb::service']
}
