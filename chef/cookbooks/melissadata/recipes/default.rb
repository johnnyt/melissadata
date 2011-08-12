include_recipe 'ubuntu'

package 'git-core'

%w[ rake bundler i18n thor activesupport multi_json yajl-ruby ].each{ |gem| gem_package gem }

include_recipe 'rvm::r192'

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

%w[ tcp unix ].each do |transport|
  template "md_#{transport}_server.init" do
    path "/etc/init.d/md_#{transport}_server"
    owner "root"
    group "root"
    mode "0755"
    action :create_if_missing
  end

  service "md_#{transport}_server" do
    action :enable
  end
end

