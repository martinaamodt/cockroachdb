#
#
# @summary
#   This class is called from the cockroachdb class to configure the program.
#
#
class cockroachdb::server::config {

  file { "/home/${cockroachdb::server::user}":
    ensure => directory,
    before => User[$cockroachdb::server::user]
  }

  user { $cockroachdb::server::user:
    ensure => present,
    home   => "/home/${cockroachdb::server::user}",
    shell  => '/bin/bash',
  }

  file { $cockroachdb::server::workingdirectory:
    ensure  => directory,
    owner   => $cockroachdb::server::user,
    require => User[$cockroachdb::server::user],
  }

  if $cockroachdb::server::secure_mode == true {
    file { $cockroachdb::server::certs_dir:
      ensure  => directory,
      owner   => $cockroachdb::server::user,
      require => User[$cockroachdb::server::user]
    }
  }
}
