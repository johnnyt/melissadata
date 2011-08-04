module MelissaData::NativeObject
  class Email < Base
    def initialize(opts={})
      @obj = MdEmailRubyWrapper::MdEmail.new
      obj.SetPathToEmailFiles(data_dir)
      obj.SetCorrectSyntax(1) # Enable/disable syntax correction
      obj.SetStandardizeCasing(1) # Enable/disable lowercasing of email
      obj.SetDatabaseLookup(1) # Enable/disable lookups against internal database of known domain names
      obj.SetMXLookup(0) # Enable/disable DNS lookups for MX records (slower - but can be more accurate)
      obj.SetUpdateDomain(1)

      @result_codes = [
        ['ES01', "Valid domain name"],
        ['ES02', "Invalid domain name"],
        ['ES03', "Domain name could not be verified"],
        ['ES10', "Syntax was changed/corrected"],
        ['ES11', "Top level domain was changed"],
        ['ES12', "Domain name spelling was corrected"],
        ['ES13', "Domain name was updated"],
        ['EE01', "Syntax error in email address"],
        ['EE02', "Top level domain not found"],
        ['EE03', "Mail server not found"]
      ]

      @defaults = {
        :email => ''
      }

      # At least one of these needs to be present
      @required_fields = [:email]

      super
    end

    def parse_input
      obj.VerifyEmail(input[:email].to_s)
    end

    def assign_values
      @output = {
        :mailbox_name => obj.GetMailBoxName,
        :domain_name => obj.GetDomainName,
        :top_level_domain => obj.GetTopLevelDomain,
        :top_level_domain_description => obj.GetTopLevelDomainDescription,
        :email => obj.GetEmailAddress,
        :lookup_code => obj.GetStatusCode
      }

      # V - Verified
      # U - Unverified - not confirmed by lookup, but was not in the invalid domains list
      # X - Bad email address - either not located by MX lookup, or was on the invalid domains list
      if output[:lookup_code] == 'U'
        obj.SetMXLookup(1)
        obj.VerifyEmail(input[:email])
        obj.SetMXLookup(0)

        process_result_codes
      end
    end
  end
end
