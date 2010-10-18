require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Screen::Window do

    before do
        @window_name = 'window_name'
        @session_name = 'session_name'
    end

    describe '.new' do

      it 'when called with first=true' do
          Kernel.should_receive(:system).once.with("screen -X -S #{@session_name} title #{@window_name}")
          Screen::Window.new(@window_name, 0, @session_name, true)
      end

      it 'when called with first=false' do
          Kernel.should_receive(:system).once.with("screen -X -S #{@session_name} screen -t #{@window_name} 1")
          Screen::Window.new(@window_name, 1, @session_name, false)
      end

    end

    describe '#exec' do
      
      before do
          Kernel.stub!(:system => 'stubbed')
          @window_number = 1
          @first_window = false
          @window = Screen::Window.new(@window_name, @window_number, @session_name, @first_window)
      end

      it 'when called with one string' do
          Kernel.should_receive(:system).with(
             %Q|screen -X -S #{@session_name} -p #{@window_number} stuff "ls\n"|
          )
          @window.exec('ls')
      end

      it 'when called with array of strings' do
          Kernel.should_receive(:system).with(
             %Q|screen -X -S #{@session_name} -p #{@window_number} stuff "ls\nwc\n"|
          )
          @window.exec('ls', 'wc')
      end

      it 'when called with one array of strings' do
          Kernel.should_receive(:system).with(
             %Q|screen -X -S #{@session_name} -p #{@window_number} stuff "ls\nwc\nps\n"|
          )
          @window.exec(['ls', 'wc', 'ps'])
      end

      it 'when called with unpredictables' do
          lambda {
              @window.exec(1, {}, [])
          }.should raise_error(ArgumentError, 'not unix command')
      end

    end

    describe '#method_missing' do

      before do
          Kernel.stub!(:system => 'stubbed')
          @window_number = 1
          @first_window = false
          @window = Screen::Window.new(@window_name, @window_number, @session_name, @first_window)
      end

      it 'called with no args' do
          Kernel.should_receive(:system).with(
             %Q|screen -X -S #{@session_name} -p #{@window_number} hoge|
          )
          @window.method_missing('hoge')
      end

      it 'called with string' do
          Kernel.should_receive(:system).with(
             %Q|screen -X -S #{@session_name} -p #{@window_number} hoge fuga|
          )
          @window.method_missing('hoge', 'fuga')
      end

      it 'called with strings and numbers' do
          Kernel.should_receive(:system).with(
             %Q|screen -X -S #{@session_name} -p #{@window_number} hoge 1|
          )
          @window.method_missing('hoge', 1)
      end

    end

end

