#
#
# @summary
#   This class is called from the the cockroachdb class for installation.
#
#
class cockroachdb::server::install {

  package { $cockroachdb::server::dependencies:
    ensure   => installed,
    provider => apt,
    before   => Archive[$cockroachdb::server::archive_name],
  }

  archive { $cockroachdb::server::archive_name:
    path         => "/tmp/${cockroachdb::server::archive_name}",
    source       => $cockroachdb::server::cockroachdb_package_source,
    extract      => true,
    extract_path => '/tmp/',
    creates      => "${cockroachdb::server::install_path}/${cockroachdb::server::package_name}",
    cleanup      => true,
    before       => File["${cockroachdb::server::install_path}/${cockroachdb::server::package_name}"],
  }

  file { "${cockroachdb::server::install_path}/${cockroachdb::server::package_name}":
    ensure => present,
    source => "/tmp/${cockroachdb::server::package_name}-${cockroachdb::server::package_ensure}/${cockroachdb::server::package_name}",
    mode   => '0755',
  }
}
