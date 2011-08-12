module MelissaData::VagrantPlugin

  module Actions
    autoload :Base,       'vagrant_plugin/actions/base'
    autoload :Install,    'vagrant_plugin/actions/install'
    autoload :Update,     'vagrant_plugin/actions/update'
  end

end
