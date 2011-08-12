require 'msgpack/rpc'

module MelissaData::Client

  class Vagrant
    attr_reader :rpc

    def initialize
      # @socket_file = "/tmp/melissa-data"
      # @rpc = MessagePack::RPC::Client.new(MessagePack::RPC::UNIXTransport.new, @socket_file)
      @rpc = MessagePack::RPC::Client.new('127.0.0.1', 14004)
    end

    def process_ip(ip)
      rpc.call :process_ip, ip
    end

    def ip_build_number
      rpc.call :ip_build_number
    end

    def version
      rpc.call :version
    end
  end

end
