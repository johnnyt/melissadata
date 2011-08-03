module MelissaData
  # Constants used by the system to access data.
  module Constants
    SERVER          = 'MelissaData'

    # Default execution port
    DEFAULT_PORT    = 6000

    # Default execution address
    DEFAULT_ADDRESS = '0.0.0.0'

    DEFAULT_SHARED_OBJECTS_PATH = '/opt/melissa_data/lib'

    LOCALHOST       = 'localhost'
    STATUS          = 'status'
    CONFIG          = 'config'
    OPTIONS         = 'options'

    SERVER_NAME     = 'SERVER_NAME'
    SERVER_PORT     = 'SERVER_PORT'
    SCRIPT_NAME     = 'SCRIPT_NAME'
    REMOTE_ADDR     = 'REMOTE_ADDR'
    CONTENT_LENGTH  = 'CONTENT_LENGTH'
    CONTENT_TYPE    = 'CONTENT_TYPE'
    REQUEST_METHOD  = 'REQUEST_METHOD'
    REQUEST_URI     = 'REQUEST_URI'
    QUERY_STRING    = 'QUERY_STRING'
    HTTP_VERSION    = 'HTTP_VERSION'
    REQUEST_PATH    = 'REQUEST_PATH'
    PATH_INFO       = 'PATH_INFO'
    FRAGMENT        = 'FRAGMENT'
    CONNECTION      = 'CONNECTION'
  end
end

module MelissaData
  include Constants
end
