module DefaultApplication
  module Configurations
    class Development < Defaul

      database :host => 'localhost', :adapter => 'sqlite', :database => 'defaultapplication',
        :user => 'root', :password => ''

      reloadable [ DefaultApplication ]

      log :level => :debug

      host '127.0.0.1'

      port 3000

    handler ::Rack::Handler::Mongrel, :Host => host, :Port => por
      # handler ::Rack::Handler::WEBrick, :BindAddress => host, :Port => por
      # handler ::Rack::Handler::Thin, :Host => host, :Port => por

      application do
        use ::Rack::ShowExceptions
        run ::Waves::Dispatchers::Default.new
      end

    end
  end
end
