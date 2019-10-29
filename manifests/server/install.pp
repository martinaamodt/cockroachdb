#
#
# @summary
#   This class is called from the the cockroachdb class for installation.
#
# @api private
#
class cockroachdb::server::install {
  $dependencies = $cockroachdb::dependencies
  $archive_name = $cockroachdb::archive_name
  $cockroachdb_package_source = $cockroachdb::cockroachdb_package_source
  $install_path = $cockroachdb::install_path
  $package_name = $cockroachdb::package_name
  $package_ensure = $cockroachdb::package_ensure

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
