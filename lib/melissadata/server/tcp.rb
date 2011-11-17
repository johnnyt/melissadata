module MelissaData::Server

  class TCP < Base
    def run(host=MelissaData::DEFAULT_TCP_ADDRESS, port=MelissaData::DEFAULT_TCP_PORT)
      trap("INT")  { self.stop }
      trap("TERM") { self.stop }

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
