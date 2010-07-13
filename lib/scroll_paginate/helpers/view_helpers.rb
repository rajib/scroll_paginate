module ScrollPaginate
  module Helpers
    module ViewHelpers
      # DECRIPTION: will add require css and javascript file to layout.
      # EXAMPLE: <%= include_scroll_paginate %>
      def include_scroll_paginate
        html = '<link href="/stylesheets/scroll_paginate/default/jqpageflow.css" media="screen" rel="stylesheet" type="text/css" />
        <script src="/javascripts/scroll_paginate/default/jquery.jqpageflow.js" type="text/javascript"></script>'
      end

      # DESCRIPTION: will generete the javascript block for enebaling
      #	scroll pagination.
      # EXAMPLE: <%= scroll_paginate(:url => 'example.com',
      #                              :total_results => 100,
      #                              :container => "mycontainer",
      #                              :current_page => 0,
      #                              :per_page => 20,
      #                              :pager_var => 'page',
      #                              :loader_img_path => 'images/loader.gif',
      #                              :loader_text => 'Loading...',
      #                              :debug => 1) %>
      # :url ( required field :EXAMPLE => 'example.com', :NOTE => Dont put http;// )
      # :total_results ( required field :EXAMPLE => User.count )
      # :container ( required field :EXAMPLE => Container Div for scroll pagination )
      #	:current_page ( optional :DESCRIPTION => Gets appended to url as a GET value to help your backend
      #	script keep track of which page of results the user is on. Defaults to 0 (first page) ),
      #	:per_page ( optional :DESCRIPTION => Used for calculation and display purposes, tell the plugin how
      #	many results are being displayed per page. Defaults to 50.),
      #	:pager_var ( optional :DESCRIPTION => Related to currentPage, gets appended to url as a GET var to help
      # your backend script keep track of which page of results the user is on (e.g. index.php?page=2).
      # Defaults to "page" )
      #	:loader_img_path ( optional :DESCRIPTION => Tell the plugin where to find the loader img relative to
      #	the page calling the plugin. Defaults to "images/scroll_paginate/default/loader.gif" ),
      # :loader_text ( optional :DESCRIPTION => Add a text msg to Ajax loader )
      #	:debug ( optional :DESCRIPTION => When set to 1, the plugin will print debugging information to the
      #	console (firebug). Defaults to 0  ) %>
      def scroll_paginate(options)
        # initialize variables
        setup_options(options)
        html = "<script type='text/javascript'>
          $(document).ready(function(){
            $('body').flexiPagination({
                url: '#{@url}',
                totalResults: #{@total_results},
                container: '#{@container}',
                currentPage: #{@current_page},
                perPage: #{@per_page},
                pagerVar : '#{@pager_var}',
                loaderImgPath: '#{@loader_img_path}',
                loaderText: '#{@loader_text}',
                debug : #{@debug}
              });
            });
            </script>"
      end

      # return calculated offset
      def calculate_offset(num, page=nil)
        page ? page.to_i * num : 0
      end

      private
      def setup_options(options)
        @url = options[:url]
        @total_results = options[:total_results]
        @container = "##{options[:container]}" # concait # for DIV id
        @current_page = options[:current_page] || 0
        @per_page = options[:per_page] || 20
        @pager_var = options[:pager_var] || 'page'
        @loader_img_path = options[:loader_img_path] || 'images/scroll_paginate/default/loader.gif'
        @loader_text = options[:loader_text] || 'Loading...'
        @debug = options[:debug] || 1
      end
    end
  end
end

