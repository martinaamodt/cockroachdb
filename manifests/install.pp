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

  $package_name = 'cockroachdb'
  $repository_url = 'https://binaries.cockroachdb.com'
  $archive_name = "${package_name}-${cockroachdb::package_ensure}.tgz"
  $cockroachdb_package_source = "${repository_url}/${archive_name}"

  archive { $cockroachdb::archive_name:
    path         => "/tmp/${archive_name}",
    source       => $cockroachdb_package_source,
    extract      => true,
    extract_path => $cockroachdb::install_path,
    creates      => "${cockroachdb::install_path}/${package_name}",
    cleanup      => true,
  }

  file { '/usr/local/bin/cockroach':
    ensure => present,
    source => '/tmp/cockroach-v19.1.5.linux-amd64/cockroach',
    mode   => '0755',
    after  => Archive[$cockroachdb::archive_name]
  }
}
