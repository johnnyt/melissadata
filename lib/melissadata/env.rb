module MelissaData
  # MelissaData::Env also provides access to the logger, configuration information
  # and anything else set into the config data during initialization.
  class Env < Hash
    include Constants

    # Create a new MelissaData::Env object
    #
    # @return [MelissaData::Env] The MelissaData::Env object
    def initialize
      self[:start_time] = Time.now.to_f
      self[:time] = Time.now.to_f
      self[:trace] = []
    end

    # Add a trace timer with the given name into the environment. The tracer will
    # provide information on the amount of time since the previous call to {#trace}
    # or since the MelissaData::Env object was initialized.
    #
    # @example
    #   trace("initialize hash")
    #   ....
    #   trace("Do something else")
    #
    # @param name [String] The name of the trace to add
    def trace(name)
      self[:trace].push([name, "%.2f" % ((Time.now.to_f - self[:time]) * 1000)])
      self[:time] = Time.now.to_f
    end

    # Retrieve the tracer stats for this request environment. This can then be
    # returned in the headers hash to in development to provide some simple
    # timing information for the various API components.
    #
    # @example
    #   [200, {}, {:meta => {:trace => env.trace_stats}}, {}]
    #
    # @return [Array] Array of [name, time] pairs with a Total entry added.
    def trace_stats
      self[:trace] + [['total', self[:trace].collect { |s| s[1].to_f }.inject(:+).to_s]]
    end

    # Convenience method for accessing the rack.logger item in the environment.
    #
    # @return [Logger] The logger object
    def logger
      return @logger if @logger

      # Figure out where the output should go to.
      output = nil
      if ENV["MELISSADATA_LOG"] == "STDOUT"
        output = STDOUT
      elsif ENV["MELISSADATA_LOG"] == "NULL"
        output = nil
      elsif ENV["MELISSADATA_LOG"]
        output = ENV["MELISSADATA_LOG"]
      else
        output = nil #log_path.join("#{Time.now.to_i}.log")
      end

      # Create the logger and custom formatter
      @logger = Logger.new(output)
      @logger.formatter = Proc.new do |severity, datetime, progname, msg|
        "#{datetime} - #{progname} - [#{resource}] #{msg}\n"
      end

      @logger
    end

    # @param name [Symbol] The method to check if we respond to it.
    # @return [Boolean] True if the Env responds to the method, false otherwise
    def respond_to?(name)
      return true if has_key?(name.to_s)
      return true if self['config'] && self['config'].has_key?(name.to_s)
      super
    end

    # The MelissaData::Env will provide any of it's keys as a method. It will also provide
    # any of the keys in the config object as methods. The methods will return
    # the value of the key. If the key doesn't exist in either hash this will
    # fall back to the standard method_missing implementation.
    #
    # @param name [Symbol] The method to look for
    # @param args The arguments
    # @param blk A block
    def method_missing(name, *args, &blk)
      return self[name.to_s] if has_key?(name.to_s)
      return self['config'][name.to_s] if self['config'] && self['config'].has_key?(name.to_s)
      super(name, *args, &blk)
    end
  end
end
