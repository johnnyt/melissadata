module MelissaData::Client

  class TCP < Base
    class << self
      def available?
        TCPSocket.new(host, port)
        true
      rescue Errno::ECONNREFUSED
        false
      end

      def host
        '127.0.0.1'
      end

      def port
        MelissaData::DEFAULT_TCP_PORT
      end
    end

    def initialize
      @rpc = MessagePack::RPC::Client.new(host, port)
    end

    def host
      self.class.host
    end

    def port
      self.class.port
    end
  end

end
