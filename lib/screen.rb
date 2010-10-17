
require 'screen/session.rb'
require 'screen/window.rb'

module Kernel
    def Screen(session, &block)
        Screen::Session.create(session, &block)
    end
end

