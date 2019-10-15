#!/opt/puppetlabs/puppet/bin/ruby
# Puppet Task Name: init
#
# This is where you put the shell code for your task.
#
require 'json'
require 'open3'
require 'puppet'

def cluster_init(host, port, user, insecure, certs_dir, url)
  cmd_string = 'cockroach init'
  cmd_string += " --host=#{host}" unless host.nil?
  cmd_string += " --port=#{port}" unless port.nil?
  cmd_string += " --user=#{user}" unless user.nil?
  cmd_string += " --insecure=#{insecure}" unless insecure.nil?
  cmd_string += " --certs-dir=#{certs_dir}" unless certs_dir.nil?
  cmd_string += " --url=#{url}" unless url.nil?

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

begin
  result = cluster_init(host, port, user, insecure, certs_dir, url)
  puts result
  exit 0
rescue Puppet::Error => e
  puts(status: 'failure', error: e.message)
  exit 1
end
