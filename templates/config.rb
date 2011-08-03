config[:license]            = "<%= options[:license] %>"
config[:objects]            = %w[ email name phone ]
config[:path]               = "<%= options[:install_path] %>"
config[:ruby_dir]           = "<%= options[:ruby_dir] %>"
config[:remote_bucket]      = "<%= options[:data_bucket_name] %>"
config[:data_username]      = "<%= options[:data_username] %>"
config[:data_api_key]       = "<%= options[:data_api_key] %>"


# config['test'] = options[:test]
# 
# import('shared')
# 
# environment :production do
#   config['prod'] = 'my prod'
# end
# 
# environment :development do
#   config['dev'] = 'my dev'
# end
