require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Screen::Session do

    before do
        @session_name = 'session_name'
    end

    describe '.create' do

        it 'create good Screen::Session object' do
            expect = lambda {}
            Screen::Session.should_receive(:new).once.and_return(
                mock.tap {|m| m.should_receive(:instance_eval).once.with(&expect) }
            )
            Kernel.should_receive(:system).once.with("screen -x #{@session_name} -p 0")

            Screen::Session.create(@session_name, &expect)
        end

    end

    describe '.new' do

        it 'sets default instance variables' do
            @session = Screen::Session.new(@session_name)
            @session.instance_variable_get('@session').should == @session_name
            @session.instance_variable_get('@first_window').should be_true
            @session.instance_variable_get('@window_number').should == 0
        end

        it 'and it creates detached io-enabled session with session_name' do
            Kernel.should_receive(:system).once.with("screen -d -m -S #{@session_name}\n")
            @session = Screen::Session.new(@session_name)
        end

    end

    describe '#window' do

        before do
            @session = Screen::Session.new(@session_name)
            @window_name = 'new_window'
        end

        it 'when only name is given' do
            Screen::Window.should_receive(:new).once.with(@window_name, 0, @session_name, true)
            @session.window(@window_name)
        end

        it 'when only block is given' do
            expect = lambda {}
            Screen::Window.should_receive(:new).once.with('w0', 0, @session_name, true).and_return(
                mock {|m| m.should_receive(:instance_eval).once.with(&expect) }
            )
            @session.window(&expect)
        end

        it 'when name and block are given' do
            expect = lambda {}
            Screen::Window.should_receive(:new).once.with(@window_name, 0, @session_name, true).and_return(
                mock {|m| m.should_receive(:instance_eval).once.with(&expect) }
            )
            @session.window(@window_name, &expect)
        end
       
        it 'when called two times' do
            Screen::Window.should_receive(:new).once.with(@window_name, 0, @session_name, true)
            @session.window(@window_name)

            Screen::Window.should_receive(:new).once.with(@window_name, 1, @session_name, false).and_return(
                mock {|m| m.should_receive(:instance_eval).once.with(&expect) }
            )
            @session.window(@window_name)
        end

    end

end

