# Helper code for tasks

def cockroach_client_con(host, port, user, insecure, certs_dir, url)
  host_flags = ''
  host_flags += " --host=#{host}" unless host.nil?
  host_flags += " --port=#{port}" unless port.nil?
  host_flags += " --user=#{user}" unless user.nil?
  host_flags += " --insecure=#{insecure}" unless insecure.nil?
  host_flags += " --certs-dir=#{certs_dir}" unless certs_dir.nil?
  host_flags += " --url=#{url}" unless url.nil?
  host_flags
end
