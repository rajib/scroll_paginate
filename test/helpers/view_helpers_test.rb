require File.join(File.dirname(__FILE__), '../test_helper.rb')

class ViewHelpersTest < ActionView::TestCase
  include ScrollPaginate::Helpers::ViewHelpers

  context "have scroll_paginate" do
    should  "return true" do
      assert scroll_paginate(:url => 'http://example.com', :total_results => 100,
      :container => "mycontainer")
    end
  end

  context "generate scroll_pagination " do
    context "with minimum option" do
      setup do
        @result_array = []
        @expected_array = ["<script type='text/javascript'>", "$(document).ready(function(){", "$('body').flexiPagination({",
        "url: 'http://example.com',", "totalResults: 100,", "container: '#mycontainer',", "currentPage: 0,",
        "perPage: 20,", "pagerVar : 'page',", "loaderImgPath: 'images/scroll_paginate/default/loader.gif',",
        "loaderText: 'Loading...',", "debug : 1", "});", "});", "</script>"]

        result_html = scroll_paginate(:url => 'http://example.com', :total_results => 100,
        :container => "mycontainer")
        result_html.each {|s| @result_array << s.strip}
      end

      should "return true when result_array and expected_array are same" do
        assert_equal @result_array, @expected_array
      end
    end

    context "with maximum option" do
      setup do
        @result_array = []
        @expected_array = ["<script type='text/javascript'>", "$(document).ready(function(){", "$('body').flexiPagination({",
        "url: 'http://abc.com',", "totalResults: 200,", "container: '#mycustomcontainer',", "currentPage: 2,",
        "perPage: 10,", "pagerVar : 'page',", "loaderImgPath: 'images/custom/loader.gif',",
        "loaderText: 'Loading please wait',", "debug : 1", "});", "});", "</script>"]

        result_html = scroll_paginate(:url => 'http://abc.com', :total_results => 200,
        :container => "mycustomcontainer", :current_page => 2,
        :per_page => 10, :pager_var => 'page', :loader_img_path => 'images/custom/loader.gif',
        :loader_text => 'Loading please wait', :debug => 1)
        result_html.each {|s| @result_array << s.strip}
      end

      should "return true when result_array and expected_array are same" do
        assert_equal @result_array, @expected_array
      end
    end

    context "calculate_offset" do
      should "return calculated offset as 0 without any page" do
       assert_equal calculate_offset(30), 0
      end

      should "return calculated offset as 60 with page" do
       assert_equal calculate_offset(30, 2), 60
      end
    end
  end
end

