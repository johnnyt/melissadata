module MelissaData::NativeObject

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
