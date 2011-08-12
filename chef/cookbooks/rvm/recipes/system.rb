bash "Download and run rvm-install-system-wide" do
  code "bash < <(curl -s https://rvm.beginrescueend.com/install/rvm)"
  not_if "[ -e /usr/local/rvm ]"
end

# %w[ readline zlib ].each do |rvm_package|
#   bash "Install RVM #{rvm_package} package" do
#     code "/usr/local/rvm/bin/rvm pkg install #{rvm_package}"
#     not_if "[ -e $rvm_path/usr/lib/lib#{rvm_package}.so ]"
#   end
# end

bash "Install RVM Readline package" do
  code "/usr/local/rvm/bin/rvm pkg install readline"
  not_if "[ -e $rvm_path/usr/lib/libreadline.so ]"
end

bash "Install RVM zlib package" do
  code "/usr/local/rvm/bin/rvm pkg install zlib"
  not_if "[ -e $rvm_path/usr/lib/libz.so ]"
end

(node[:accounts] || 'vagrant').each do |username, options|
  group 'rvm' do
    members username
    append true
  end
end
