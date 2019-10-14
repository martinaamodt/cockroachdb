# == class cockroachdb
#
# Example cockroachdb usage with required parameters
#
class { 'cockroachdb':
  install_path   => '/usr/local/bin',
  package_ensure => 'v19.1.5.linux-amd64',
  node1ip        => 'db0',
  node2ip        => 'db1',
  node3ip        => 'db2',
}