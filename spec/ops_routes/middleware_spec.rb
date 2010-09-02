require 'spec_helper'

describe OpsRoutes::Middleware do

  before do
    @parent_app = mock("Rails App")
    @parent_app.stub(:call).and_return([200, {}, ['Parent App']])
    @parent_app.stub(:env).and_return({})
  end
  
  def app
    @app ||= OpsRoutes::Middleware.new(@parent_app) do |ops|
      ops.file_root = File.join(File.dirname(__FILE__), '..')
    end
  end
  
  context "passing routes" do

    it "should pass to parent app for /" do
      @parent_app.should_receive(:call)
      get '/'
    end
    
    it "should pass to parent app for /Georgia/Atlanta" do
      @parent_app.should_receive(:call)
      get '/Georgia/Atlanta'
    end
    
  end

  context "captured routes" do

    context "version" do

      it "should not pass to parent app for '/ops/version'" do
        @parent_app.should_not_receive(:call)
        get '/ops/version'
      end

      it "should call check_version" do
        OpsRoutes.should_receive(:check_version).and_return("The version page")
        get '/ops/version'
      end

    end

    context "heartbeat" do

      it "should not pass to parent app for '/ops/heartbeat'" do
        @parent_app.should_not_receive(:call)
        get '/ops/version'
      end

      it 'should call check_heartbeat' do
        OpsRoutes.should_receive(:check_heartbeat).with(nil).and_return(
          :status => 200,
          :text => 'OK')
        get '/ops/heartbeat'
      end

      context "named heartbeat" do
        it 'should call check_heartbeat with heartbeat name' do
          OpsRoutes.should_receive(:check_heartbeat).with('foo').and_return(
            :status => 200,
            :text => 'OK')
          get '/ops/heartbeat/foo'
        end
      end

    end

    context "configuration" do
      it 'should call check_configuration' do
        OpsRoutes.should_receive(:check_configuration).and_return('The configuration page')
        get '/ops/configuration'
      end

      it 'should call the configuration block' do
        config_block = lambda{}
        OpsRoutes.add_configuration_section(:test, &config_block)
        config_block.should_receive(:call).and_return( :key => 'value' )
        get '/ops/configuration'
      end
    end

  end

end
