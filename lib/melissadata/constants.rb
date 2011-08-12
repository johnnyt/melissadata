module MelissaData

  module Constants
    DEFAULT_TCP_ADDRESS = '0.0.0.0'
    DEFAULT_TCP_PORT    = 1404
    DEFAULT_SOCKET_FILE = '/tmp/melissadata.sock'

    DEFAULT_VAGRANT_TCP_PORT = 14004
  end

end

module MelissaData
  include Constants
end
