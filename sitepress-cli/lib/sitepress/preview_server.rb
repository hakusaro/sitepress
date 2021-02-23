require "rack"
require "rails"
require "sitepress-server"

module Sitepress
  # Evaluates a configuration file on each site request, then delegates to
  # a sitepres server for rednering. In a production environment, you'd want
  # to run `Sitepress::Server` directly.
  class PreviewServer
    DEFAULT_PORT = 8080
    DEFAULT_BIND_ADDRESS = "0.0.0.0".freeze

    attr_reader :server

    def initialize(server: Sitepress::Server)
      @server = server
    end

    def run(port: DEFAULT_PORT, bind_address: DEFAULT_BIND_ADDRESS)
      # TODO: Move all of this junk into the PreviewServer class. Move
      # what's in there now into PreviewServer::Rack
      Rack::Handler::WEBrick.run server,
        BindAddress: bind_address,
        Port: port do |server|
          Signal.trap "SIGINT" do
            server.stop
          end
      end
    end
  end
end
