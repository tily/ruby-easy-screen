$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

# exec command sample

require 'screen'

Screen('admin') {
    window('vi')   { exec 'vi' }
    window('top')  { exec 'top' }
    window('tail') { exec 'tail -f /var/log/apache2/error_log' }
}

