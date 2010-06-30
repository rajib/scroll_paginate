require File.join(File.dirname(__FILE__), '../test_helper.rb')

class ViewHelpersTest < ActionView::TestCase
  include ScrollPaginate::Helpers::ViewHelpers

	should "have scroll_paginate" do
    assert scroll_paginate(:url => 'http://example.com', :total_results => 100,
													 :container => "mycontainer")
  end
  
  should "generate scroll_pagination " do
    setup do
      @html = "<script type='text/javascript'>\n
	    \t\t\t\t\t\t\t\t\t$(document).ready(function(){\n
	    \t\t\t\t\t\t\t\t  \t$('body').flexiPagination({\n
	    \t\t\t\t\t\t\t\t  \t\turl: 'http://example.com',\n
	    \t\t\t\t\t\t\t\t\t\t\ttotalResults: 100,\n
	    \t\t\t\t\t\t\t\t\t\t\tcontainer: '#mycontainer',\t\t\t\t\t\t\t\t \t\t\t\n
	    \t\t\t\t\t\t\t\t\t\t\tcurrentPage: 0,\n
	    \t\t\t\t\t\t\t\t \t\t\tperPage: 20,\n
	    \t\t\t\t\t\t\t\t \t\t\tpagerVar : 'p',\n
	    \t\t\t\t\t\t\t\t \t\t\tloaderImgPath: 'images/scroll_paginate/default/loader.gif',\n
	    \t\t\t\t\t\t\t\t \t\t\tdebug : 1\n
	    \t\t\t\t\t\t\t\t  \t});\n
	    \t\t\t\t\t\t\t\t\t});\n
	    \t\t\t\t\t\t\t\t</script>"
    end
    
	  should "with minimum option" do
		  assert_equal scroll_paginate(:url => 'http://example.com', 
		                               :total_results => 100,
													         :container => "mycontainer"), @html
	  end
	end
end
