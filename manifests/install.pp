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
    before   => Download_uncompress['dwnl_inst_cockroach'],
  }
  download_uncompress { 'dwnl_inst_cockroach':
    download_base_url => 'https://binaries.cockroachdb.com',
    distribution_name => 'cockroach-v19.1.5.linux-amd64.tgz',
    dest_folder       => '/tmp',
    creates           => '/tmp/cockroach',
    uncompress        => 'tar.gz',
    before            => File['/usr/local/bin/cockroach'],
  }

  file { '/usr/local/bin/cockroach':
    ensure => present,
    source => '/tmp/cockroach-v19.1.5.linux-amd64/cockroach',
    mode   => '0755',
  }
}
