require 'melissa-data/melissa-data'
require 'msgpack/rpc'
require 'msgpack/rpc/transport/unix'

module MelissaData
  module RPC
    include Constants

    class Client
      attr_reader :rpc

      def initialize
        @socket_file = "/tmp/melissa-data"
        @rpc = MessagePack::RPC::Client.new(MessagePack::RPC::UNIXTransport.new, @socket_file)
      end

      # def method_missing(meth, *args, &blck)
      #   rpc.call meth, args
      # end

      def process_email(email)
        rpc.call :process_email, email
      end

      def email_build_number
        rpc.call :email_build_number
      end

      def version
        rpc.call :version
      end

      def address
        "#{@host}:#{@port}"
      end
    end

  end
end
