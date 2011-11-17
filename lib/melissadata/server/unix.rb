require 'msgpack/rpc/transport/unix'

module MelissaData::Server

  class Unix < Base
    def run
      trap("INT")  { self.stop }
      trap("TERM") { self.stop }

      @socket_file = MelissaData::DEFAULT_SOCKET_FILE
      File.delete @socket_file if File.exists? @socket_file
      listener = MessagePack::RPC::UNIXServerTransport.new @socket_file
      server.listen(listener, self)
      puts "== MelissaData Unix server is running - socket file: #{@socket_file}"
      server.run
    end

    def stop
      puts "== Stopping MelissaData Unix server"
      server.stop
      File.delete @socket_file if File.exists? @socket_file
    end
  end

end
