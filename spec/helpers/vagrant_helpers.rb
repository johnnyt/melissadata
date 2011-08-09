require 'vagrant'
module Vagrant
  class VM
    def exit_status(command)
      return_val = 'unknown'
      ssh.execute do |ssh|
        ssh.exec!(command) do |channel, type, data|
          return_val = data if type == :exit_status
        end
      end
      return_val
    end
  end
end

module VagrantHelpers
end
