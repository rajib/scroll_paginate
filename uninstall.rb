##
## Delete public files
##

require 'fileutils'

directory = File.dirname(__FILE__)

[ :stylesheets, :javascripts, :images].each do |file_type|
  path = File.join(directory, "../../../public/#{file_type}/scrolle_paginate")
  FileUtils.rm_r(path)
end
