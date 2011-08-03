module MelissaData
  class Geo < Base
    def initialize(opts={})
      @obj = MdGeoRubyWrapper::MdGeo.new
      obj.SetPathToGeoCodeDataFiles(data_dir)
      obj.SetPathToGeoPointDataFiles(data_dir)

      @result_codes = [
        ['GS01', "Geocoded to ZIP+4"],
        ['GS02', "Geocoded to ZIP+2"],
        ['GS03', "Geocoded to ZIP"],
        ['GS05', "Geocoded to rooftop level"],
        ['GS06', "Geocoded to interpolated rooftop level"],
        ['GE01', "Invalid zip code"],
        ['GE02', "Zip code not found"],
        ['GE03', "Demo mode"],
        ['GE04', "Expired database"]
      ]

      @defaults = {
        :zip => '',
        :plus4 => ''
      }

      # At least one of these needs to be present
      @required_fields = [:zip]

      super
    end

    def parse_input
      if ((dpc = input[:delivery_point_code]) || (dpc = input[:dpc])).present?
        obj.GeoPoint(input[:zip].to_s, input[:plus4].to_s, dpc.to_s)
      else
        obj.GeoCode(input[:zip].to_s, input[:plus4].to_s)
      end
    end

    def assign_values
      @output = {
        :lat => obj.GetLatitude,
        :lng => obj.GetLongitude,
        :county_name => obj.GetCountyName,
        :county_fips => obj.GetCountyFips,
        :census_tract => obj.GetCensusTract,
        :census_block => obj.GetCensusBlock,
        :place_name => obj.GetPlaceName,
        :place_code => obj.GetPlaceCode,
        :time_zone => obj.GetTimeZone,
        :time_zone_code => obj.GetTimeZoneCode,

        :cbsa_code => obj.GetCBSACode,
        :cbsa_level => obj.GetCBSALevel,
        :cbsa_title => obj.GetCBSATitle,
        :cbsa_division_code => obj.GetCBSADivisionCode,
        :cbsa_division_title => obj.GetCBSADivisionTitle,
        :cbsa_division_level => obj.GetCBSADivisionLevel
      }
    end
  end
end
