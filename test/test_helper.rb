require "rubygems"
require "test/unit"

require "rubygems"
gem "activerecord"
gem "actionpack"
require "active_record"
require "action_controller"
require "active_support/test_case"

require "lib/default_attribute_value"

ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")
ActiveRecord::Base.configurations = YAML::load(IO.read(File.dirname(__FILE__) + "/database.yml"))
ActiveRecord::Base.establish_connection(ENV["DB"] || "mysql")

load(File.dirname(__FILE__) + "/schema.rb")

require File.dirname(__FILE__) + "/product"