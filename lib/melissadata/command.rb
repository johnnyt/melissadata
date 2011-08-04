module MelissaData
  module Command
    autoload :Base,      'melissadata/command/base'
    autoload :Helpers,   'melissadata/command/helpers'
  end
end

# The built-in commands must always be loaded
require 'melissadata/command/package'
require 'melissadata/command/compile'
