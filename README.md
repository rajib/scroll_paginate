ScrollPaginate
==============

Plugin for js scroll pagination. Inspired by ActiveScaffold
<ul>
  <li><a href="http://scrollpaginate.heroku.com/">View Rails App demo</a></li>
  <li><a href="http://scrollpaginate.heroku.com/doc/index.html">Documentation</a></li>
</ul>

Installation
============
#### ./script/plugin install git@github.com:rajib/scroll_paginate.git


Example
=======
## Controller
    class UsersController < ApplicationController
      # GET /users
      # GET /users.xml
      def index
        respond_to do |format|
          format.html # index.html.erb
          format.xml  { render :xml => @users }
        end
      end

      # fetch_by_offset_users
      # GET    /users/fetch_by_offset
      def fetch_by_offset
        respond_to do |format|
          format.js { render :partial => 'fetch_by_offset', :locals => {:page => params[:page]} }
        end
      end
    end

## View Helper
    module UsersHelper
      def generate_list(num, page=nil)
        offset = calculate_offset(num, page)

        # AR stuffs
        collection = User.find(:all, :limit => num, :offset => offset)
        #

        content = []
        for i in collection
          content << "<li> #{i.name} </li>"
        end

        sleep(2)
        return content
      end
    end

## Views
###users/index.html.erb
    <ol id="mycontainer">
      <%= generate_list(20) %>
    </ol>

###users/_fetch_by_offset.erb
`<%= generate_list(20, page) %>`

###layouts/application.html.erb
    <head>
      <%= javascript_include_tag("jquery") %>
      <%= include_scroll_paginate %>
      <%= scroll_paginate(:url => "/users/fetch_by_offset",
                          :total_results => 200,
					      :container => "mycontainer",
					      :per_page => 20,
					      :pager_var => "page") %>
    </head>


Copyright (c) 2010 Rajib Chowdhury, released under the MIT license

