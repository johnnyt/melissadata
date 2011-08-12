module MelissaData
  module Client
    autoload :Base,       'melissadata/client/base'
    autoload :TCP,        'melissadata/client/tcp'
    autoload :Unix,       'melissadata/client/unix'
    autoload :Vagrant,    'melissadata/client/vagrant'
  end
end
