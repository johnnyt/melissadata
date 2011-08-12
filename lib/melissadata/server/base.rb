require 'active_support/core_ext'

module MelissaData::Server

  class Base
    attr_reader :server

    def initialize
      @server = MessagePack::RPC::Server.new
    end

    def run
      raise 'I should have been overridden'
    end

    def process(opts={})
      setup(opts)
      process_address
      process_email
      process_geo
      process_name
      process_phone
      process_ip

      data
    end

    def setup(opts)
      @input = opts.dup
      @data = {}
    end

    def input
      @input ||= {}
    end

    def data
      @data ||= {}
    end

    def process_address(address=nil, zip=nil, city=nil, state=nil)
      output = {}
      input[:address] = address if address.present?
      input[:zip] = zip if zip.present?
      input[:city] = city if city.present?
      input[:state] = state if state.present?

      output = address_object.process(input)
      output.delete_if{ |k,v| v.to_s.strip == "" }
      data[:address] = output
      output
    end
    alias_method :address, :process_address

    def process_email(email=nil)
      output = {}
      input[:email] = email.to_s if email.present?

      output = email_object.process(input)
      output.delete_if{ |k,v| v.to_s.strip == "" }
      data[:email] = output
      output
    end
    alias_method :email, :process_email

    def process_geo(zip=nil, plus4=nil, dpc=nil)
      output = {}

      input[:zip] = zip.to_s if zip.present?
      input[:plus4] = plus4.to_s if plus4.present?
      input[:delivery_point_code] = dpc.to_s if dpc.present?

      output = geo_object.process(input)
      output.delete_if{ |k,v| v.to_s.strip == "" }
      data[:geo] = output

      output
    end
    alias_method :geo, :process_geo

    def process_name(first_name=nil, last_name=nil)
      output = {}
      input[:first_name] = first_name if first_name.present?
      input[:last_name] = last_name if last_name.present?

      output = name_object.process(input)
      output.delete_if{ |k,v| v.to_s.strip == "" }
      data[:name] = output
      output
    end
    alias_method :name, :process_name

    def process_phone(phone=nil, zip=nil)
      output = {}
      input[:phone] = phone if phone.present?
      input[:zip] = zip.to_s if zip.present?

      output = phone_object.process(input)
      output.delete_if{ |k,v| v.to_s.strip == "" }
      data[:phone] = output
      output
    end
    alias_method :phone, :process_phone

    def process_ip(ip=nil)
      output = {}
      input[:ip] = ip if ip.present?

      output = ip_object.process(input)
      output.delete_if{ |k,v| v.to_s.strip == "" }
      data[:ip] = output
      output
    end
    alias_method :ip, :process_ip

    def address_object
      @address_object ||= MelissaData::NativeObject::Address.new
    end

    def email_object
      @email_object ||= MelissaData::NativeObject::Email.new
    end

    def geo_object
      @geo_object ||= MelissaData::NativeObject::Geo.new
    end

    def name_object
      @name_object ||= MelissaData::NativeObject::Name.new
    end

    def phone_object
      @phone_object ||= MelissaData::NativeObject::Phone.new
    end

    def ip_object
      @ip_object ||= MelissaData::NativeObject::IpLocator.new
    end

    def version
      MelissaData::VERSION
    end
  end

end
