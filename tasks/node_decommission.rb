#!/opt/puppetlabs/puppet/bin/ruby
# Puppet Task Name: node_decommission
#
# This is where you put the shell code for your task.
#
require 'json'
require 'open3'
require 'puppet'
require_relative '../files/helper.rb'

def node_decommission(wait, host_flags)
  cmd_string = 'cockroach node ls'
  cmd_string += " --wait=#{wait}" unless wait.nil?

  stdout, stderr, status = Open3.capture3(cmd_string + host_flags)
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
wait = params['wait']

begin
  host_flags = cockroach_client_con(host, port, user, insecure, certs_dir, url)
  result = node_decommission(wait, host_flags)
  puts result
  exit 0
rescue Puppet::Error => e
  puts(status: 'failure', error: e.message)
  exit 1
end
