# encoding: UTF-8
module Gusy
  class App < Padrino::Application
    register Padrino::Mailer
    register Padrino::Helpers

    enable :sessions

    ## Instance Configuration
    set :config, YAML::load(File.open("#{Padrino.root}/config/gusy.conf.yml"))

    ## Mailer config
    set :delivery_method, :smtp => settings.config['smtp']
    #{
    #  :address              => "mymailserver.de",
    #  :port                 => 25, 
    #  :user_name            => "mymailaccount",
    #  :password             => "mypass",
    #  :authentication       => :plain,
    #  :enable_starttls_auto => true}
    #logger.warn(settings.delivery_method)

    # We want to allow iframe inclusion
    set :protection, :except => :frame_options

    # Accomodation options.
    set :rooms, ['Eigenes Zelt', 'Mehrbettzimmer', 'Einzelzimmer', 'Doppelzimmer', '2-Bett-Zimmer', 'Hütte', 'Kubus', 'Bauwagen', 'Eigenes Wohnmobil/-wagen', 'Privat / Selbstorganisiert']

    ##
    # Caching support.
    #
    # register Padrino::Cache
    # enable :caching
    #
    # You can customize caching store engines:
    #
    # set :cache, Padrino::Cache.new(:LRUHash) # Keeps cached values in memory
    # set :cache, Padrino::Cache.new(:Memcached) # Uses default server at localhost
    # set :cache, Padrino::Cache.new(:Memcached, '127.0.0.1:11211', :exception_retry_limit => 1)
    # set :cache, Padrino::Cache.new(:Memcached, :backend => memcached_or_dalli_instance)
    # set :cache, Padrino::Cache.new(:Redis) # Uses default server at localhost
    # set :cache, Padrino::Cache.new(:Redis, :host => '127.0.0.1', :port => 6379, :db => 0)
    # set :cache, Padrino::Cache.new(:Redis, :backend => redis_instance)
    # set :cache, Padrino::Cache.new(:Mongo) # Uses default server at localhost
    # set :cache, Padrino::Cache.new(:Mongo, :backend => mongo_client_instance)
    # set :cache, Padrino::Cache.new(:File, :dir => Padrino.root('tmp', app_name.to_s, 'cache')) # default choice
    #

    ##
    # Application configuration options.
    #
    # set :raise_errors, true       # Raise exceptions (will stop application) (default for test)
    # set :dump_errors, true        # Exception backtraces are written to STDERR (default for production/development)
    # set :show_exceptions, true    # Shows a stack trace in browser (default for development)
    # set :logging, true            # Logging in STDOUT for development and file for production (default only for development)
    # set :public_folder, 'foo/bar' # Location for static assets (default root/public)
    # set :reload, false            # Reload application files (default in development)
    # set :default_builder, 'foo'   # Set a custom form builder (default 'StandardFormBuilder')
    # set :locale_path, 'bar'       # Set path for I18n translations (default your_apps_root_path/locale)
    # disable :sessions             # Disabled sessions by default (enable if needed)
    # disable :flash                # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
    # layout  :my_layout            # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
    #

    ##
    # You can configure for a specified environment like:
    #
    #   configure :development do
    #     set :foo, :bar
    #     disable :asset_stamp # no asset timestamping for dev
    #   end
    #

    ##
    # You can manage errors like:
    #
    #   error 404 do
    #     render 'errors/404'
    #   end
    #
    #   error 500 do
    #     render 'errors/500'
    #   end

    error 404 do
      @title = "Oh no!"
      render 'errors/404'
    end

    # Set locale according to pre-postfix
    before do
      @menu = Gusy::GusyMenu.new
      I18n.locale = session[:locale] || :de
      if request.path_info =~ /^\/(#{I18n.available_locales.join('|')})(.*)/
        session[:locale] = $1.to_sym
        logger.info ("update locale #{session[:locale]}")
        redirect $2
      end
    end

    get /.*index\.php.*/ do
      redirect "http://siebenlinden.de/index.php?#{request.query_string.to_s}"
    end

    get '/impressum' do
      render 'impressum'
    end

    get '/' do
      redirect url('seminar')
    end
  end
end
