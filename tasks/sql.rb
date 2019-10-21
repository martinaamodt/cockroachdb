#!/opt/puppetlabs/puppet/bin/ruby

# Puppet Task Name: sql
#
# This is where you put the shell code for your task.
#

require 'json'
require 'open3'
require 'puppet'

def cluster_init(host, port, user, insecure, certs_dir, url, database, echo_sql, execute, format, safe_updates, set)
  cmd_string = 'cockroach sql'
  cmd_string += " --host=#{host}" unless host.nil?
  cmd_string += " --port=#{port}" unless port.nil?
  cmd_string += " --user=#{user}" unless user.nil?
  cmd_string += " --insecure=#{insecure}" unless insecure.nil?
  cmd_string += " --certs-dir=#{certs_dir}" unless certs_dir.nil?
  cmd_string += " --url=#{url}" unless url.nil?
  cmd_string += " --database=#{database}" unless database.nil?
  cmd_string += " --echo-sql=#{echo_sql}" unless echo_sql.nil?
  cmd_string += " --execute=#{execute}" unless execute.nil?
  cmd_string += " --format=#{format}" unless format.nil?
  cmd_string += " --safe-updates=#{safe_updates}" unless safe_updates.nil?
  cmd_string += " --set=#{set}" unless set.nil?

  stdout, stderr, status = Open3.capture3(cmd_string)
  raise Puppet::Error, "stderr: '#{stderr}'" if status != 0
  stdout.strip
end

params = JSON.parse(STDIN.read)
host = params['host']
port = params['port']
user = params['user']
insecure = params['insecure']
certs_dir = params['certs_dir']
url = params['url']
database = params['database']
echo_sql = params['echo_sql']
execute = params['execute']
format = params['format']
safe_updates = params['safe_updates']
set = params['set']


begin
  result = cluster_init(host, port, user, insecure, certs_dir, url, database, echo_sql, execute, format, safe_updates, set)
  puts result
  exit 0
rescue Puppet::Error => e
  puts(status: 'failure', error: e.message)
  exit 1
end
