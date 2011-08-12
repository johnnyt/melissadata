module MelissaData::Client

  class Vagrant < TCP
    def self.port
      MelissaData::DEFAULT_VAGRANT_TCP_PORT
    end
  end

end
