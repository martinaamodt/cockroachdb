# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include cockroachdb::config
class cockroachdb::config {

  file { '/home/cockroach':
    ensure => directory,
    before => User['cockroach']
  }

  user { 'cockroach':
    ensure => present,
    home   => '/home/cockroach',
    shell  => '/bin/bash',
  }

  file { '/var/lib/cockroach':
    ensure  => directory,
    owner   => 'cockroach',
    require => User['cockroach'],
  }

  file { '/etc/systemd/system/insecurecockroachdb.service':
    ensure  => file,
    content => epp('cockroachdb/insecurecockroachdb.service.epp' ),
    notify  => Service['insecurecockroachdb'],
  }

  service { 'insecurecockroachdb':
    ensure => 'running',
  }
}
