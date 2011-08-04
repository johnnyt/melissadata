module MelissaData::NativeObject
  class Address < Base
    def initialize(opts={})
      @obj = MdAddrRubyWrapper::MdAddr.new
      obj.SetPathToUSFiles(data_dir)
      obj.SetUseUSPSPreferredCityNames(1)

      @result_codes = [
        ['AS01', "Address matched to postal database"],
        ['AS09', "Foreign postal code detected"],
        ['AS10', "Address matched to CMRA"],
        ['AS12', "Address deliverable by non-USPS carriers"],
        ['AS13', "Address has been updated by LACS"],
        ['AS14', "Suite appended by SuiteLink"],
        ['AS15', "Suite appended by AddressPlus"],
        ['AS16', "Address is vacant"],
        ['AS17', "Alternate delivery"],
        ['AE01', "Zip code"],
        ['AE02', "Unknown street"],
        ['AE03', "Component mismatch"],
        ['AE04', "Non-deliverable address"],
        ['AE05', "Multiple match"],
        ['AE06', "Early warning system error"],
        ['AE07', "Missing minimum address input"],
        ['AE08', "Suite range invalid"],
        ['AE09', "Suite range missing"],
        ['AE10', "Primary range invalid"],
        ['AE11', "Primary range missing"],
        ['AE12', "PO, HC, or RR box number invalid"],
        ['AE13', "PO, HC, or RR box number missing"],
        ['AE14', "CMRA secondary missing"],
        ['AE15', "Demo mode"],
        ['AE16', "Expired database"]
      ]

      @defaults = {
        :company => '',
        :address => '',
        :address2 => '',
        :city => '',
        :state => '',
        :zip => '',
        :last_name => ''
      }

      # At least one of these needs to be present
      @required_fields = [:address, :city, :state, :zip]

      super
    end

    def parse_input
      obj.ClearProperties
      obj.SetCompany   input[:company].to_s
      obj.SetAddress   input[:address].to_s
      obj.SetAddress2  input[:address2].to_s
      obj.SetCity      input[:city].to_s
      obj.SetState     input[:state].to_s
      obj.SetZip       input[:zip].to_s
      obj.SetLastName  input[:last_name].to_s

      obj.VerifyAddress
    end

    def assign_values
      @output = {
        :company => obj.GetCompany,
        :address => obj.GetAddress,
        :address2 => obj.GetAddress2,
        :suite => obj.GetSuite,
        :city => obj.GetCity,
        :state => obj.GetState,
        :zip => obj.GetZip,
        :plus4 => obj.GetPlus4,
        :country_code => obj.GetCountryCode,
        :urbanization => obj.GetUrbanization,

        :parsed_address_range => obj.GetParsedAddressRange,
        :parsed_pre_direction => obj.GetParsedPreDirection,
        :parsed_street_name => obj.GetParsedStreetName,
        :parsed_post_direction => obj.GetParsedPostDirection,
        :parsed_suffix => obj.GetParsedSuffix,
        :parsed_suite_name => obj.GetParsedSuiteName,
        :parsed_suite_range => obj.GetParsedSuiteRange,
        :parsed_garbage => obj.GetParsedGarbage,
        :parsed_private_mailbox_name => obj.GetParsedPrivateMailboxName,
        :parsed_private_mailbox_number => obj.GetParsedPrivateMailboxNumber,

        :carrier_route => obj.GetCarrierRoute,
        :delivery_point_code => obj.GetDeliveryPointCode,
        :delivery_point_check_digit => obj.GetDeliveryPointCheckDigit,

        :address_type_code => obj.GetAddressTypeCode,
        :address_type_string => obj.GetAddressTypeString,

        :city_abbrev => obj.GetCityAbbreviation,

        :cmra => obj.GetCMRA, # Commercial Mail Receiving Agency
        :private_mailbox => obj.GetPrivateMailbox, # mailbox number at the CMRA

        :msa => obj.GetMsa,
        :pmsa => obj.GetPmsa,

        :time_zone => obj.GetTimeZone,
        :time_zone_code => obj.GetTimeZoneCode,

        :county_name => obj.GetCountyName,
        :county_fips => obj.GetCountyFips,
        :congressional_district => obj.GetCongressionalDistrict,
        :zip_type_code => obj.GetZipType
      }

      output[:zip_type] = case output[:zip_type_code]
                            when 'P' then 'PO Boxes only'
                            when 'U' then 'Unique - organization or government'
                            when 'M' then 'Military'
                            else       'Standard'
                          end

      output[:zip9] = "#{output[:zip]}-#{output[:plus4]}" if output[:plus4].present?
      output[:zip11] = "#{output[:zip9]}-#{output[:delivery_point_code]}" if output[:delivery_point_code].present?
    end
  end
end
