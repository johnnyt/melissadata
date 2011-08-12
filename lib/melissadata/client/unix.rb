require 'rev'
require 'msgpack/rpc/transport/base'
require 'msgpack/rpc/transport/unix'

module MelissaData::Client

  class Unix < Base
    def self.available?
      File.exists? socket_file
    end

    def self.socket_file
      MelissaData::DEFAULT_SOCKET_FILE
    end

    def initialize
      transport = MessagePack::RPC::UNIXTransport.new
      @rpc = MessagePack::RPC::Client.new transport, self.class.socket_file
    end
  end

end
