$LOAD_PATH.unshift File.dirname(__FILE__) unless $LOAD_PATH.include?(File.dirname(__FILE__))
# Load constants, be able to set environment
require 'melissa-data/melissa-data'

# begin
#   # puts "== Trying to load native MelissaData shared objects"
#   require 'melissa-data/shared_objects'
#   MelissaData.client = MelissaData::SharedObjects::Client.new

# rescue LoadError => err
#   # Shared Objects don't exist - try to connect to Vagrant RPC
#   if err.message =~ %r@#{MelissaData::DEFAULT_SHARED_OBJECTS_PATH}@
#     # puts "   Doh! - not available"

#     require 'melissa-data/rpc'
#     MelissaData.client = MelissaData::RPC::Client.new('127.0.0.1', 23457)
#     # puts "== Trying to connect to RPC server at #{MelissaData.client.address}"

#   else
#     raise err
#   end
# end
