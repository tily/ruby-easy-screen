
module Screen

    class Window

        instance_methods.each do |method|
            undef_method method unless method[/^(__|instance_eval$)/]
        end

        def initialize(window, window_number, session, first)
            @session = session
            @window_number = window_number
            if first
                title window
            else
                system "screen -X -S #{@session} screen -t #{window} #{@window_number}"
            end
        end

        def exec(*args)
            if args.all? {|a| a.class == String }
                stuffed = args
            elsif args[0].class == Array and args[0].all? {|a| a.class == String }
                stuffed = args[0]
            else
                raise ArgumentError, ''
            end
            stuffed = %Q|"#{stuffed.join("\n")}\n"|
            system "screen -X -S #{@session} -p #{@window_number} stuff #{stuffed}"
        end

        def method_missing(command, *args)
            unix_command = "screen -X -S #{@session} -p #{@window_number} #{command}"
            args = args.map {|a| a.class == String ? %Q|"#{a}"| : a.to_s }
            unix_command += " #{args.join(' ')}"
            system unix_command
        end
    
    end

end

