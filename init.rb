# load environment.rb
require File.dirname(__FILE__) + '/environment'
##
## Run the install files script, too, just to make sure
## But at least rescue the action in production
##
begin
  require File.dirname(__FILE__) + '/install'
rescue
  raise $! unless Rails.env == 'production'
end


