require 'test/unit'
require 'rubygems'
require 'active_support'
require 'active_support/test_case'
require 'action_controller'
require 'action_view/test_case'
require 'mocha'
gem 'thoughtbot-shoulda', ">= 2.9.0"
require 'shoulda'
require "#{File.expand_path("scroll_paginate/helpers", "lib")}/view_helpers"

ENV['RAILS_ENV'] = 'test'
