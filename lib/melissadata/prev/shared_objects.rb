md_path = File.expand_path('../..', File.dirname(__FILE__))
$LOAD_PATH.unshift md_path unless $LOAD_PATH.include?(md_path)

require 'melissa-data/constants'

module MelissaData
  module SharedObjects

    class Client
      attr_reader :license

      def initialize(license='INVALID LICENSE')
        @license = license
        @email_object = MelissaData::Email.new(:license => license)
      end

      def process_email(email=nil)
        email ||= ''
        output = {}
        input = {:email => email.to_s}
        output = @email_object.process(input)
        output.delete_if{ |k,v| v.to_s.strip == "" }
        output
      end

      def email_build_number
        @email_object.obj.GetBuildNumber
      end

      def version
        MelissaData::VERSION
      end

      def address
        "SharedObjects"
      end
    end

  end
end

%w[
  mdAddrRubyWrapper mdEmailRubyWrapper mdGeoRubyWrapper mdNameRubyWrapper mdPhoneRubyWrapper mdIpLocatorRubyWrapper
].each do |obj|
  require File.join(MelissaData::DEFAULT_SHARED_OBJECTS_PATH, obj)
end

require 'melissa-data/shared_objects/base'
require 'melissa-data/shared_objects/email'
require 'melissa-data/shared_objects/address'
require 'melissa-data/shared_objects/geo'
require 'melissa-data/shared_objects/ip_locator'
require 'melissa-data/shared_objects/name'
require 'melissa-data/shared_objects/phone'
