Encoding.default_external = "utf-8"

# default RACK_ENV to `development`
ENV['RACK_ENV'] ||= 'development'

# log to stdout
require 'logger'
$logger = Logger.new STDOUT
STDOUT.sync = true

# connect to the database
require 'active_record'
ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
ActiveRecord::Base.logger = $logger
