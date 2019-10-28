#
#
# @summary
#   This class is called from the cockroachdb class to configure the program.
#
#
class cockroachdb::config {

  file { "/home/${cockroachdb::user}":
    ensure => directory,
    before => User[$cockroachdb::user]
  }

  user { $cockroachdb::user:
    ensure => present,
    home   => "/home/${cockroachdb::user}",
    shell  => '/bin/bash',
  }

  file { $cockroachdb::workingdirectory:
    ensure  => directory,
    owner   => $cockroachdb::user,
    require => User[$cockroachdb::user],
  }

  if $cockroachdb::secure_mode == true {
    file { $cockroachdb::certs_dir:
      ensure  => directory,
      owner   => $cockroachdb::user,
      require => User[$cockroachdb::user]
    }
  }
}
