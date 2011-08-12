require 'msgpack'
require 'msgpack/rpc'

module MelissaData
  module Server
    autoload :Base,       'melissadata/server/base'
    autoload :TCP,        'melissadata/server/tcp'
    autoload :Unix,       'melissadata/server/unix'
  end
end
