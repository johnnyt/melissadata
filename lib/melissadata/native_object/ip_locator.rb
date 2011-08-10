require '/opt/melissadata/lib/mdIpLocatorRubyWrapper'

module MelissaData::NativeObject
  class IpLocator < Base
    def initialize(opts={})
      @obj = MdIpLocatorRubyWrapper::MdIpLocator.new
      obj.SetPathToIpLocatorFiles(data_dir)

      @result_codes = [
        ['IS01', "IP Address found in database"],
        ['IS02', "IP Address unknown"],
        ['IE01', "IP Address was empty or not well formed"]
      ]

      @defaults = {
        :ip => ''
      }

      # At least one of these needs to be present
      @required_fields = [:ip]

      super
    end

    def parse_input
      obj.LocateIpAddress(input[:ip].to_s)
    end

    def assign_values
      @output = {
        :domain_name => obj.GetDomainName,
        :isp => obj.GetISP,
        :city => obj.GetCity,
        :region => obj.GetRegion,
        :zip => obj.GetZip,
        :country => obj.GetCountry,
        :country_abbrev => obj.GetCountryAbbreviation,
        :lat => obj.GetLatitude,
        :lng => obj.GetLongitude
      }
    end
  end
end
