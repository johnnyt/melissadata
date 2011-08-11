module MelissaData

  module NativeObject
    module_function

    autoload :Base,       'melissadata/native_object/base'
    autoload :Client,     'melissadata/native_object/client'

    autoload :Address,    'melissadata/native_object/address'
    autoload :Email,      'melissadata/native_object/email'
    autoload :Geo,        'melissadata/native_object/geo'
    autoload :IpLocator,  'melissadata/native_object/ip_locator'
    autoload :Name,       'melissadata/native_object/name'
    autoload :Phone,      'melissadata/native_object/phone'

    def license
      @license ||= begin
        default_filename = '/opt/melissadata/license.txt'

        if File.exists?(default_filename)
          File.read().chomp
        elsif (env_license = ENV['MELISSADATA_LICENSE'])
          env_license
        end
      end
    end
  end

end
