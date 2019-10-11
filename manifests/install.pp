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
    extract_path => $cockroachdb::install_path,
    creates      => "${cockroachdb::install_path}/${cockroachdb::package_name}",
    cleanup      => true,
  }

  file { '/usr/local/bin/cockroach':
    ensure => present,
    source => '/tmp/cockroach-v19.1.5.linux-amd64/cockroach',
    mode   => '0755',
    after  => Archive[$cockroachdb::archive_name]
  }
}
