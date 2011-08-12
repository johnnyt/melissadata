module MelissaData::Server

  class TCP < Base
    def run
      trap("INT")  { self.stop }
      trap("TERM") { self.stop }

      host = MelissaData::DEFAULT_TCP_ADDRESS
      port = MelissaData::DEFAULT_TCP_PORT
      server.listen(host, port, self)

      puts "== MelissaData TCP server is now listening on #{host}:#{port}"
      server.run
    end

    def stop
      puts "== Stopping MelissaData TCP server"
      server.stop
    end
  end

end
