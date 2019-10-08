# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include cockroachdb
class cockroachdb(
  Tuple $dependencies
){
  contain cockroachdb::install
  contain cockroachdb::config
  Class['::cockroachdb::install'] -> Class['::cockroachdb::config']
}
