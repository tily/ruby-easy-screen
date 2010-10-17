$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

# just open four new windows and set name to each

require 'screen'

Screen('Beatles') {
    ['John', 'Paul', 'George', 'Ringo'].each {|member|
        window(member)
    }
}

