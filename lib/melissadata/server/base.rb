module MelissaData::Server

  class Base
    attr_reader :server

    def initialize
      @server = MessagePack::RPC::Server.new
    end

    def run
      raise 'I should have been overridden'
    end

    def process_ip(ip=nil)
      ip ||= ''
      output = {}
      input = {:ip => ip.to_s}
      output = ip_object.process(input)
      output.delete_if{ |k,v| v.to_s.strip == "" }
      output
    end

    def ip_build_number
      ip_object.obj.GetBuildNumber
    end

    def ip_object
      @ip_object ||= MelissaData::NativeObject::IpLocator.new
    end

    def version
      MelissaData::VERSION
    end
  end

end
