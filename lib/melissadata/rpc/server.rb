# require 'msgpack/rpc'
# require 'msgpack/rpc/transport/unix'

module MelissaData::RPC

  class Server
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
