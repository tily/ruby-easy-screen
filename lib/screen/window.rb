
module Screen

    class Window

        instance_methods.each do |method|
            undef_method method unless method[/^(__|instance_eval$)/]
        end

        def initialize(window, window_number, session, first)
            @session = session
            @window_number = window_number
            if first
                Kernel.system "screen -X -S #{@session} title #{window}"
            else
                Kernel.system "screen -X -S #{@session} screen -t #{window} #{@window_number}"
            end
        end

        def exec(*args)
            if args.all? {|a| a.class == String }
                stuffed = args
            elsif args[0].class == Array and args[0].all? {|a| a.class == String }
                stuffed = args[0]
            else
                raise ArgumentError, 'not unix command'
            end
            stuffed = %Q|"#{stuffed.join("\n")}\n"|
            Kernel.system "screen -X -S #{@session} -p #{@window_number} stuff #{stuffed}"
        end

        def method_missing(command, *args)
            unix_command = "screen -X -S #{@session} -p #{@window_number} #{command}"
            if !args.size.zero?
                args = args.map {|a| a.class == String ? a : a.to_s }
                unix_command << " #{args.join(' ')}"
            end
            Kernel.system unix_command
        end
    
    end

end

