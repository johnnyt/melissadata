module MelissaData::NativeObject
  class Name < Base
    def initialize(opts={})
      @obj = MdNameRubyWrapper::MdName.new
      obj.SetPathToNameFiles(data_dir)

      @result_codes = [
        ['NS01', "Parsing was successful"],
        ['NS02', "There was a parse error"],
        ['NS03', "The spelling of the FirstName field was corrected"],
        ['NS04', "The spelling of the FirstName2 field was corrected"],
        ['NE01', "Two names were detected but the FullName string was not in a recognized format"],
        ['NE02', "Multiple first names - could not accurately genderize"],
        ['NE03', "A vulgarity was detected in the first name"],
        ['NE04', "The name contained words found on the list of nuisance names [such as Mickey Mouse]"],
        ['NE05', "The name contained words normally found in a company name"],
        ['NE06', "The named contained a non-alphabetic character"]
      ]

      @defaults = {
        :first_name => '',
        :last_name => ''
      }

      # At least one of these needs to be present
      @required_fields = [:first_name, :last_name, :full_name]

      # 0 - don't correct spelling of first name
      # 1 - attempt to correct common misspellings of first name
      obj.SetFirstNameSpellingCorrection(1) 

      # Formatting of the FullName input
      # 1 - Definitely Full
      # 2 - Very Likely Full
      # 3 - Probably Full
      # 4 - Varying (default)
      # 5 - Probably Inverse
      # 6 - Very Likely Inverse
      # 7 - Definitely Inverse
      # 8 - Mixed First Name
      # 9 - Mixed Last Name
      obj.SetPrimaryNameHint(1)

      super
    end

    def parse_input
      input[:full_name] = ("%s %s" % [input[:first_name], input[:last_name]]) if input[:full_name].blank?
      obj.ClearProperties
      obj.SetFullName input[:full_name].to_s
      obj.Parse
    end

    def assign_values
      genders = {
        'M' => 'Male',
        'F' => 'Female',
        'U' => 'Unknown first name',
        'N' => 'Neutral first name'
      }

      @output = {
        :prefix => obj.GetPrefix,
        :first_name => obj.GetFirstName,
        :middle_name => obj.GetMiddleName,
        :last_name => obj.GetLastName,
        :suffix => obj.GetSuffix,
        :gender => obj.GetGender,
        :gender_string => genders[obj.GetGender]
      }
      # status_messages << "First name spelling was corrected" if name_obj.GetChangeCode == 1
    end
  end
end
