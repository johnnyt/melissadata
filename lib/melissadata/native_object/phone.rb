require '/opt/melissadata/lib/mdPhoneRubyWrapper'

module MelissaData::NativeObject
  class Phone < Base
    def initialize(opts={})
      @obj = MdPhoneRubyWrapper::MdPhone.new
      if obj.Initialize(data_dir) != 0
        raise obj.GetInitializeErrorString
      end

      @result_codes = [
        ["PS01", "10 digit match"],
        ["PS02", "7 digit match"],
        ["PS03", "Corrected Area Code"],
        ["PS04", "Outside Demo Range"],
        ["PS05", "Expired Database"],
        ["PS06", "Updated Area Code"],
        ["PS07", "Exchange Type: Cell Phone"],
        ["PS08", "Exchange Type: Land Line"],
        ["PS09", "Exchange Type: VOIP"],
        ["PS10", "Phone Type: Residential"],
        ["PS11", "Phone Type: Business"],
        ["PS12", "Phone Type: Small Business or Home Office"],
        ["PE01", "Bad area code"],
        ["PE02", "Blank phone number"],
        ["PE03", "Bad phone number - too many or too few digits"],
        ["PE04", "Multiple phone matches"],
        ["PE05", "Bad prefix - does not exist in the database"],
        ["PE06", "Bad zip code"]
      ]

      @defaults = {
        :phone => '',
        :zip => ''
      }

      # At least one of these needs to be present
      @required_fields = [:phone]

      super
    end

    def parse_input
      obj.Lookup(input[:phone].to_s, input[:zip].to_s)
    end

    def assign_values
      @output = {
        :lat => obj.GetLatitude,
        :lng => obj.GetLongitude,
        :city => obj.GetCity,
        :state => obj.GetState,
        :county_name => obj.GetCountyName,
        :county_fips => obj.GetCountyFips,
        :country_code => obj.GetCountryCode,
        :time_zone => obj.GetTimeZone,
        :time_zone_code => obj.GetTimeZoneCode,
        :msa => obj.GetMsa,
        :pmsa => obj.GetPmsa,
        :time_zone => obj.GetTimeZone,
        :time_zone_code => obj.GetTimeZoneCode,
        :area_code => obj.GetAreaCode,
        :prefix => obj.GetPrefix,
        :suffix => obj.GetSuffix,
        :extension => obj.GetExtension
      }

      codes = result_codes.split(',')
      output[:exchange_type] =  if codes.include?('PS07')
                                  'Cell Phone'

                                elsif codes.include?('PS08')
                                  'Land Line'

                                elsif codes.include?('PS09')
                                  'VOIP'
                                end

      output[:phone_type] = if codes.include?('PS07')
                              'Residential'

                            elsif codes.include?('PS07')
                              'Business'

                            elsif codes.include?('PS07')
                              'Small Business or Home Office'
                            end

      # if opts[:zip].present?
      #   phone_obj.CorrectAreaCode(opts[:phone], opts[:zip])
      #   hsh[:new_area_code] = phone_obj.GetNewAreaCode
      # end

      output[:formatted_phone] = "(#{output[:area_code]}) #{output[:prefix]}-#{output[:suffix]}"
      output[:formatted_phone] << " x#{output[:extension]}" if output[:extension].present?
    end
  end
end
