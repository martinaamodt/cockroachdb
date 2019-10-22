# == class cockroachdb
#
# Example cockroachdb usage with required parameters
#
class { 'cockroachdb':
  node1ip     => 'db0',
  node2ip     => 'db1',
  node3ip     => 'db2',
  secure_mode => false,
}