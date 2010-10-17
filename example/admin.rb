
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

# web server admin example
require 'screen'

Screen::Session.create('admin') {
    window { exec 'top' }
    window { exce 'tail -f /var/log/apache2/error_log'  }
    window { exce 'tail -f /var/log/apache2/access_log' }
}

