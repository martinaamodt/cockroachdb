# == Class cockroach::config
#
# This class is called from the cockroachdb class to configure the program.
#
#
#
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

  if $cockroachdb::secure_mode == true {
    file { $cockroachdb::certs_dir:
      ensure  => directory,
      owner   => 'cockroach',
      require => User['cockroach']
    }
  }
}
