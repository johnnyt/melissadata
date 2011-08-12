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

    def process(opts={})
      rpc.call :process, opts
    end

    def process_address(address=nil, zip=nil, city=nil, state=nil)
      rpc.call :process_address, address, zip, city, state
    end
    alias_method :address, :process_address

    def process_email(email=nil)
      rpc.call :process_email, email
    end
    alias_method :email, :process_email

    def process_geo(zip=nil, plus4=nil, dpc=nil)
      rpc.call :process_geo, zip, plus4, dpc
    end
    alias_method :geo, :process_geo

    def process_name(first_name=nil, last_name=nil)
      rpc.call :process_name, first_name, last_name
    end
    alias_method :name, :process_name

    def process_phone(phone=nil, zip=nil)
      rpc.call :process_phone, phone, zip
    end
    alias_method :phone, :process_phone

    def process_ip(ip)
      rpc.call :process_ip, ip
    end
    alias_method :ip, :process_ip

    def version
      rpc.call :version
    end
  end

end
