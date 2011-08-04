module MelissaData::NativeObject
  class Base
    attr_reader :obj, :license, :input, :output, :result_codes, :results_string
    attr_writer :data_dir

    def initialize(opts={})
      @license  = opts[:license]  || "DEMO"

      unless obj.SetLicenseString(@license)
        @license = "DEMO"
        puts "Invalid License: Running in DEMO MODE."
      end

      if obj.respond_to?(:InitializeDataFiles) && obj.InitializeDataFiles != 0
        raise obj.GetInitializeErrorString
      end
    end

    # Example: geo.process(:zip => '84108')
    #   - If invalid input (required fields are missing), return {}
    #   - Call subclass's parse_input - this should call methods on the MelissaData object
    #   - Call subclass's assign_values - pull out information from the object into the output hash
    #   - Processes result codes
    def process(opts={})
      @input = @defaults.merge(opts)
      return {} unless valid_input?

      parse_input
      @results_string = obj.GetResults.to_s
      assign_values
      process_result_codes

      output.reduce({}) do |hsh,pair|
        val = pair.last
        val.strip! if val.respond_to?(:strip)
        hsh[pair.first] = val if val.present?
        hsh
      end
    end

    def parse_input
      raise "Needs to be overridden"
    end

    def assign_values
      @output = {}
    end

    def valid_input?
      @required_fields.blank? || input.any?{ |k,v| @required_fields.include?(k) && v.present? }
    end

    def process_result_codes
      status_messages = []
      error_messages = []

      @results_string.split(",").each do |lookup|
        if (match = @result_codes.detect{ |c,m| c == lookup })
          code, message = *match

          if code[1] == 'E'
            error_messages << message
          else
            status_messages << message
          end
        end
      end

      output[:result_codes] = @results_string
      output[:messages] = {}
      output[:messages][:status] = status_messages if status_messages.present?
      output[:messages][:error] = error_messages if error_messages.present?
    end

    def data_dir
      @data_dir ||= '/opt/melissa_data/data'
    end
  end
end
