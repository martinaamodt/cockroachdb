# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include cockroachdb
class cockroachdb(
  Tuple $dependencies,
  Stdlib::Absolutepath $servicepath,
  String $description,
  Stdlib::Absolutepath $workingdirectory,
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
){
  contain cockroachdb::install
  contain cockroachdb::config
  Class['::cockroachdb::install'] -> Class['::cockroachdb::config']
}
