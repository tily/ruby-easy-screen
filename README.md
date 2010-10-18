Screen
======

Usage
-------

### Open Several Windows

    Screen('Beatles') {
        ['John', 'Paul', 'George', 'Ringo'].each {|member|
            window(member)
        }
    }

ends up like this:

<img src="http://gyazo.com/a61076d8a6035ea8ed51dd3cc6a7fe13.png" />



### Execute Commands for each Window

    Screen('admin') {
        window('vi')   { exec 'vi' }
        window('top')  { exec 'top' }
        window('tail') { exec 'tail -f /var/log/apache2/error_log' }
    }

ends up like this:

<img src="http://gyazo.com/88d2bf51e72307c33a7b189faf65ebaf.png" />

Install
-------

 gem install screen


Requirements
-------

 * ruby 1.8.7 or later
 * GNU screen

Links
-------

 * Inspired by: [Scripting Screen](http://blog.lathi.net/articles/2008/09/13/scripting-screen)
 * See also: [RubyScreen](http://ruby-screen.rubyforge.org/), [Screeninator](http://github.com/jondruse/screeninator)
 * Source code: [http://github.com/tily/ruby-screen](http://github.com/tily/ruby-screen)

Copyright
-------
Copyright (c) 2010 tily. See LICENSE for details.
