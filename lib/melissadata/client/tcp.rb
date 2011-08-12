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

    def initialize(host=self.class.host, port=self.class.port)
      @host = host
      @port = port
      @rpc = MessagePack::RPC::Client.new(@host, @port)
    end
  end

end
