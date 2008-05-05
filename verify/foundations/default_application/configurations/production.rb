module DefaultApplication

  module Configurations

    class Production < Defaul

      database :host => 'localhost', :adapter => 'mysql', :database => 'defaultapplication',
        :user => 'root', :password => ''

      reloadable []

      log :level => :error,
        :output => ( :log / "waves.#{$$}" ),
        :rotation => :weekly

      host '0.0.0.0'

      port 80

    handler ::Rack::Handler::Mongrel, :Host => host, :Port => por
      # handler ::Rack::Handler::WEBrick, :BindAddress => host, :Port => por
      # handler ::Rack::Handler::Thin, :Host => host, :Port => por

      application do
        run ::Waves::Dispatchers::Default.new
      end

    end
  end
end
