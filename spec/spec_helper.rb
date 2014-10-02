RACK_ENV = 'test' unless defined?(RACK_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")
Dir[File.expand_path(File.dirname(__FILE__) + "/../app/helpers/**/*.rb")].each(&method(:require))

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  #conf.before(:each) do
  #  existing_tables = Sequel::Model.db.tables
  #  tables_to_preserve = [:schema_info, :schema_migrations]
  #  tables_to_be_emptied = existing_tables - tables_to_preserve
  #  tables_to_be_emptied.each do |table|
  #    Sequel::Model.db[table].delete
  #  end
  #end
end

# Init FactoryGirl
#FactoryGirl.definition_file_paths = [
#  File.join(Padrino.root, 'spec', 'factories')
#  ]
#FactoryGirl.find_definitions

# You can use this method to custom specify a Rack app
# you want rack-test to invoke:
#
#   app Gusy::App
#   app Gusy::App.tap { |a| }
#   app(Gusy::App) do
#     set :foo, :bar
#   end
#
def app(app = nil, &blk)
  @app ||= block_given? ? app.instance_eval(&blk) : app
  @app ||= Padrino.application
end
