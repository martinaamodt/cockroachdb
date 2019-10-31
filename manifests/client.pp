#
#
# @summary
#   Install the cockroachdb client
#
#
# @example
#   include cockroachdb::client
#
# @param workingdirectory
#   Location of where the working directory will be created.
#   If the parameter is not defined it will be created in "/var/lib/cockroach".
#
# @param dependencies
#   Consists of dependencies 'tar' and 'wget' by default. Failing to include these dependencies while defining
#   this parameter yourself may result in dependency issues.
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
# @param cockroachdb_package_source
#   Full binary package source.
#
class cockroachdb::client (
  Optional[Stdlib::Absolutepath] $workingdirectory = $cockroachdb::params::workingdirectory,
  Optional[Tuple] $dependencies                    = $cockroachdb::params::dependencies,
  #Archive
  Optional[Stdlib::Absolutepath] $install_path     = $cockroachdb::params::install_path,
  Optional[String] $package_name                   = $cockroachdb::params::package_name,
  String $package_ensure                           = $cockroachdb::params::package_ensure,
  Optional[String] $repository_url                 = $cockroachdb::params::repository_url,
  Optional[String] $archive_name                   = $cockroachdb::params::archive_name,
  Optional[String] $cockroachdb_package_source       = $cockroachdb::params::cockroachdb_package_source,
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