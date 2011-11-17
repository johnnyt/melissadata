require_recipe "rvm::system"

bash "RVM install 1.9.2" do
  code "/usr/local/rvm/bin/rvm install 1.9.2"
  not_if "/usr/local/rvm/bin/rvm list | grep -q '1.9.2'"
end
