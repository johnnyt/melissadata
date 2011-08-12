default[:melissadata][:paths][:root_dir]        = "/opt/melissadata"
# default[:melissadata][:paths][:rpc_server_bin]  = "#{node[:languages][:ruby][:gems_dir]}/bin/md_rpc_server"
default[:melissadata][:paths][:rpc_server_bin]  = "/usr/bin/md_rpc_server"
default[:melissadata][:paths][:config_file]     = "/opt/melissadata/config.yml"
default[:melissadata][:paths][:license_file]    = "/opt/melissadata/license.txt"
default[:melissadata][:paths][:pid_file]        = "/var/run/md_rpc_server.pid"
default[:melissadata][:paths][:log_dir]         = "/var/log/melissadata"

# default[:melissadata][:user]    = "www-data"

# default[:melissadata][:use_passenger]     = true
# default[:melissadata][:ruby_path]         = "/opt/ruby-1.9.2"
# default[:melissadata][:passenger_root]    = "#{melissadata[:ruby_path]}/lib/ruby/gems/1.9.1/gems/passenger-3.0.0"
# default[:melissadata][:passenger_ruby]    = "#{melissadata[:ruby_path]}/bin/ruby"

# default[:melissadata][:src_binary]   = "#{melissadata[:install_path]}/sbin/melissadata"
# default[:melissadata][:default_site] = "/var/www/melissadata-default"



# default[:melissadata][:configure_flags] = [
#   "--prefix=#{melissadata[:install_path]}",
#   "--conf-path=#{melissadata[:conf_path]}",
#   "--with-http_ssl_module",
#   "--with-http_gzip_static_module"
# ]

# default[:melissadata][:gzip] = "on"
# default[:melissadata][:gzip_types] = [
#   "text/css",
#   "text/plain",
#   "text/xml",
#   "application/atom+xml",
#   "application/json",
#   "application/rss+xml",
#   "application/x-javascript"
# ]

# default[:melissadata][:keepalive]          = "on"
# default[:melissadata][:keepalive_timeout]  = 65
# default[:melissadata][:worker_processes]   = 4
# default[:melissadata][:worker_connections] = 1024
# default[:melissadata][:server_names_hash_bucket_size] = 64
