$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

# open six windows for webservers to tail -f apache log

require 'screen'

username = 'your_username'
password = 'your_password'

Screen('log_tail') {
    servers = ['web01', 'web02', 'web03', 'app01', 'app02', 'app03']
    servers.each {|s|
        window(s) {
            ssh s, username, password
            exec 'tail -f /var/apache2/log/error_log'
        }
    } 
}

