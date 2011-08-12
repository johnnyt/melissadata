require_recipe "rvm::system"

bash "RVM install 1.8.7" do
  code "/usr/local/rvm/bin/rvm install 1.8.7 --with-readline-dir=$rvm_path/usr"
  not_if "/usr/local/rvm/bin/rvm list | grep -q '1.8.7'"
end
