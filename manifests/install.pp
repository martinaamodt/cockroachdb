# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include cockroachdb::install
class cockroachdb::install {
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
