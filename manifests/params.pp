# Class cockroachdb::params
# =========================
#
# Default values for cockroachdb module. Non optional are undef
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
  $region = undef
  $datacenter = undef
  $zone = undef

  # Archive
  $install_path = '/usr/local/bin'
  $package_ensure = 'v19.1.5.linux-amd64'
  $package_name = 'cockroach'
  $repository_url = 'https://binaries.cockroachdb.com'
  $archive_name = "${package_name}-${package_ensure}.tgz"
  $cockroachdb_package_source = "${repository_url}/${archive_name}"
}