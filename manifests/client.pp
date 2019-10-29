# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include cockroachdb::client
class cockroachdb::client (
  Optional[Stdlib::Absolutepath] $workingdirectory                    = $cockroachdb::params::workingdirectory,
  Optional[Tuple] $dependencies                                       = $cockroachdb::params::dependencies,
  Boolean $secure_mode                                                = $cockroachdb::params::secure_mode,
  Optional[Stdlib::Absolutepath] $certs_dir                           = $cockroachdb::params::certs_dir,
  #Archive
  Optional[Stdlib::Absolutepath] $install_path                        = $cockroachdb::params::install_path,
  Optional[String] $package_name                                      = $cockroachdb::params::package_name,
  String $package_ensure                                              = $cockroachdb::params::package_ensure,
  Optional[String] $repository_url                                    = $cockroachdb::params::repository_url,
  Optional[String] $archive_name                                      = $cockroachdb::params::archive_name,
  Optional[String] $cockroach_archive_source                          = $cockroachdb::params::cockroachdb_package_source,
) inherits cockroachdb::params {
  contain cockroachdb::install

}
