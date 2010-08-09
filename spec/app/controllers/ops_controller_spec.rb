require 'spec_helper'

# Weird hacky controller specs since spec/rails explodes outside a Rails app
describe OpsController do
  let(:controller) do
    c = OpsController.new
    c.stub(:request).and_return(mock('request', :headers => {}))
    c.stub(:response).and_return(mock('response', :content_type= => true))
    c
  end

  it "should respond to version" do
    version_page = mock('version page')
    OpsRoutes.should_receive(:check_version).and_return(version_page)
    controller.should_receive(:render).with(:text => version_page)
    controller.version
  end

  it "should respond to heartbeat for unnamed heartbeat" do
    controller.stub(:params).and_return({})
    heartbeat_page = mock('heartbeat page')
    OpsRoutes.should_receive(:check_heartbeat).with(nil).and_return(heartbeat_page)
    controller.should_receive(:render).with(heartbeat_page)
    controller.heartbeat
  end

  it "should respond to heartbeat for named heartbeat" do
    controller.stub(:params).and_return({:name => 'foo'})
    heartbeat_page = mock('heartbeat page')
    OpsRoutes.should_receive(:check_heartbeat).with('foo').and_return(heartbeat_page)
    controller.should_receive(:render).with(heartbeat_page)
    controller.heartbeat
  end

end
