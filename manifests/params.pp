# Class cockroachdb::params
# =========================
#
# Default values for cockroachdb module
#
class cockroachdb::params {
  $dependencies = ['tar', 'wget']
  $servicepath = '/etc/systemd/system/'
  $description = 'Cockroach Database cluster node'
  $workingdirectory = '/var/lib/cockroach'
  $node1ip = undef
  $node2ip = undef
  $node3ip = undef
  $cache = '.25'
  $maxsqlmemory = '.25'
  $timeoutstopsec = '60'
  $restart = 'always'
  $restartsec = '10'
  $standardoutput = 'syslog'
  $standarderror = 'syslog'
  $syslogidentifier = 'cockroach'
  $user = 'cockroach'

  # Archive
  $install_path = '/usr/local/bin'
  $package_ensure = undef
  $package_name = 'cockroachdb'
  $repository_url = 'https://binaries.cockroachdb.com'
  $archive_name = "${package_name}-${cockroachdb::package_ensure}.tgz"
  $cockroachdb_package_source = "${repository_url}/${archive_name}"
}