require 'bundler'
Bundler.setup

require 'melissa-data/test_helper'

RSpec.configure do |c|
  c.include MelissaData::TestHelper, :example_group => {
    :file_path => /spec\/integration/
  }
  c.color_enabled = true
  c.formatter = 'documentation'
end
