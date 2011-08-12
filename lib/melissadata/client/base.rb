require 'msgpack'
require 'msgpack/rpc'

module MelissaData::Client

  class Base
    attr_reader :rpc

    def self.available?
      raise 'I should have been subclassed'
    end

    def initialize(*args)
      raise 'I should have been subclassed'
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
