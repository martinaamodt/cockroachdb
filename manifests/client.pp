# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include cockroachdb::client
class cockroachdb::client (
  Optional[Stdlib::Absolutepath] $workingdirectory = $cockroachdb::params::workingdirectory,
  Optional[Tuple] $dependencies                    = $cockroachdb::params::dependencies,
  Boolean $secure_mode                             = $cockroachdb::params::secure_mode,
  Optional[Stdlib::Absolutepath] $certs_dir        = $cockroachdb::params::certs_dir,
  #Archive
  Optional[Stdlib::Absolutepath] $install_path     = $cockroachdb::params::install_path,
  Optional[String] $package_name                   = $cockroachdb::params::package_name,
  String $package_ensure                           = $cockroachdb::params::package_ensure,
  Optional[String] $repository_url                 = $cockroachdb::params::repository_url,
  Optional[String] $archive_name                   = $cockroachdb::params::archive_name,
  Optional[String] $cockroach_archive_source       = $cockroachdb::params::cockroachdb_package_source,
) inherits cockroachdb::params {
  package { $cockroachdb::dependencies:
    ensure   => installed,
    provider => apt,
    before   => Archive[$cockroachdb::archive_name],
  }

  archive { $cockroachdb::archive_name:
    path         => "/tmp/${cockroachdb::archive_name}",
    source       => $cockroachdb::cockroachdb_package_source,
    extract      => true,
    extract_path => '/tmp/',
    creates      => "${cockroachdb::install_path}/${cockroachdb::package_name}",
    cleanup      => true,
    before       => File["${cockroachdb::install_path}/${cockroachdb::package_name}"],
  }

  file { "${cockroachdb::install_path}/${cockroachdb::package_name}":
    ensure => present,
    source => "/tmp/${cockroachdb::package_name}-${cockroachdb::package_ensure}/${cockroachdb::package_name}",
    mode   => '0755',
  }
}
