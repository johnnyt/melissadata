package 'git-core'

%w[ rake bundler i18n thor activesupport multi_json yajl-ruby ].each{ |gem| gem_package gem }

%w[ src lib data ].each do |subdir|
  directory "/opt/melissadata/#{subdir}" do
    owner 'vagrant'
    group 'vagrant'
    mode 0755
    action :create
    recursive true
  end
end

template "/opt/melissadata/src/Makefile" do
  owner   'vagrant'
  group   'vagrant'
end

template "md_rpc_server.init" do
  path "/etc/init.d/md_rpc_server"
  owner "root"
  group "root"
  mode "0755"
  action :create_if_missing
end

service "md_rpc_server" do
  action :enable
end
