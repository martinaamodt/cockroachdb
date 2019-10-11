# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include cockroachdb
class cockroachdb(
  # Would prefer to use Stdlib::absolutepath version. But it fails test with Puppet5
  #Stdlib::Absolutepath $servicepath,
  String $servicepath,
  #Stdlib::Absolutepath $workingdirectory,
  String $workingdirectory,
  # 
  Tuple $dependencies,
  String $description,
  String $cache,
  String $maxsqlmemory,
  String $timeoutstopsec,
  String $restart,
  String $restartsec,
  String $standardoutput,
  String $standarderror,
  String $syslogidentifier,
  String $user,
  String $node1ip,
  String $node2ip,
  String $node3ip,

  #Archive
  String $install_path,
  String $package_name,
  String $package_ensure,
  String $repository_url,
  String $archive_name,
  String $cockroach_archive_source,

){
  contain cockroachdb::install
  contain cockroachdb::config
  Class['::cockroachdb::install'] -> Class['::cockroachdb::config']
}
