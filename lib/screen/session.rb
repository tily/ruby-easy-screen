
module Screen

    class Session
    
        def self.create(session, &block)
            screen_session = new(session)
            screen_session.instance_eval(&block)
            Kernel.system "screen -x #{session} -p 0"
        end
    
        def initialize(session)
            @session       = session
            @first_window  = true
            @window_number = 0
            Kernel.system "screen -d -m -S #{@session}\n"
        end

        def window(window="w#{@window_number}", &block)
             window = Window.new(window, @window_number, @session, @first_window)
             window.instance_eval(&block) if block_given?
             @window_number += 1
             @first_window = false
        end
    
    end

end

