# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include cockroachdb::client
class cockroachdb::client (
  Optional[Stdlib::Absolutepath] $workingdirectory = $cockroachdb::params::workingdirectory,
  Optional[Tuple] $dependencies                    = $cockroachdb::params::dependencies,
  #Archive
  Optional[Stdlib::Absolutepath] $install_path     = $cockroachdb::params::install_path,
  Optional[String] $package_name                   = $cockroachdb::params::package_name,
  String $package_ensure                           = $cockroachdb::params::package_ensure,
  Optional[String] $repository_url                 = $cockroachdb::params::repository_url,
  Optional[String] $archive_name                   = $cockroachdb::params::archive_name,
  Optional[String] $cockroach_archive_source       = $cockroachdb::params::cockroachdb_package_source,
) inherits cockroachdb::params {
  package { $dependencies:
    ensure   => installed,
    provider => apt,
    before   => Archive[$archive_name],
  }

  archive { $archive_name:
    path         => "/tmp/${archive_name}",
    source       => $cockroachdb_package_source,
    extract      => true,
    extract_path => '/tmp/',
    creates      => "${install_path}/${package_name}",
    cleanup      => true,
    before       => File["${install_path}/${package_name}"],
  }

  file { "${install_path}/${package_name}":
    ensure => present,
    source => "/tmp/${package_name}-${package_ensure}/${package_name}",
    mode   => '0755',
  }
}
