package 'git-core'
%w[ bundler i18n thor activesupport multi_json yajl-ruby ].each{ |gem| gem_package gem }

# sudo "mkdir -p #{target_root}/lib #{target_root}/data #{target_root}/src && chown -R vagrant:vagrant #{target_root}"

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
  # source  "authorized_keys.erb"
  # mode    "0600"
  owner   'vagrant'
  group   'vagrant'
  # variables(:ruby_path => keys)
end
