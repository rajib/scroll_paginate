# Workaround a problem with script/plugin and http-based repos.
# See http://dev.rubyonrails.org/ticket/8189
Dir.chdir(Dir.getwd.sub(/vendor.*/, '')) do
  ##
  ## Copy over files (javascript/css/images) from the plugin directory to public/
  ##

  def copy_files(source_path, destination_path, directory)
    source, destination = File.join(directory, source_path), File.join(Rails.root, destination_path)
    FileUtils.mkdir_p(destination) unless File.exist?(destination)
    FileUtils.cp_r(Dir.glob(source+'/*.*'), destination)
  end

  directory = File.dirname(__FILE__)

  copy_files("/public", "/public", directory)

  jqpageflow_resources = Dir[File.join(directory, 'jqpageflow', '*')].collect { |d| File.basename d }
  [ :stylesheets, :javascripts, :images].each do |file_type|
    path = "/public/#{file_type}/scroll_paginate"
    copy_files(path, path, directory)

    File.open(File.join(Rails.root, path, 'DO_NOT_EDIT'), 'w') do |f|
      f.puts "Any changes made to files in sub-folders will be lost."
    end

    jqpageflow_resources.each do |jqpageflow_resource|
      source = "/jqpageflow/#{jqpageflow_resource}/#{file_type}/"
      destination = "/public/#{file_type}/scroll_paginate/#{jqpageflow_resource}"
      copy_files(source, destination, directory)
    end
  end
end
