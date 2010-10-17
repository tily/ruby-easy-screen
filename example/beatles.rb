$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

# just setup four new windows and set name to each
require 'screen'

Screen::Session.create('Beatles') {
    ['John', 'Paul', 'George', 'Ringo'].each {|member|
        window(member)
    }
}

