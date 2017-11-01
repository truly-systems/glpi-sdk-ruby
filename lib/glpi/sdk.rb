require 'pry'
require 'httparty'

# Autoload ruby files
Dir[File.join(File.dirname(__FILE__), 'sdk', '*.rb')].each do |file|
  require file
end

module GLPI
  module SDK
    # Your code goes here...
  end
end
