# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include cockroachdb::install
class cockroachdb::install {
  package { $cockroachdb::dependencies:
    provider => apt,
    ensure => installed,
  }
download_uncompress {'dwnl_inst_cockroach':
    download_base_url  => 'https://binaries.cockroachdb.com/cockroach-v19.1.5.linux-amd64.tgz',
    distribution_name  => 'cockroach-v19.1.5.linux-amd64.tgz'
    dest_folder   => '/tmp',
    creates       => '/usr/local/bin/cockroach',
    uncompress    => 'tar.gz',
  }
}
