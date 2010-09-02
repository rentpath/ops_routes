require File.join(File.dirname(File.dirname(__FILE__)), 'ops_routes')

module OpsRoutes
  class Middleware
    def initialize(app)
      @app = app
      yield OpsRoutes if block_given?
    end

    def call(env)
      return @app.call(env) unless env['PATH_INFO'] =~ %r{^/ops/(heartbeat(?:/(\w+))?|version|configuration)/?$}
      route, heartbeat_name = $1, $2
      case route
      when 'heartbeat'
        heartbeat_result = OpsRoutes.check_heartbeat(heartbeat_name)
        headers = { 'Content-Type' => 'text/plain',
                    'Content-Length' => heartbeat_result[:text].length.to_s }
        [ heartbeat_result[:status], headers, [heartbeat_result[:text]] ]
      when 'version'
        version_result = OpsRoutes.check_version(env)
        headers = { 'Content-Type' => 'text/html',
                    'Content-Length' => version_result.length.to_s }
        [ 200, headers, [version_result] ]
      when 'configuration'
        configuration_result = OpsRoutes.check_configuration
        headers = { 'Content-Type' => 'text/html',
                    'Content-Length' => configuration_result.length.to_s }
        [ 200, headers, [configuration_result] ]
      end
    end
  end
end
