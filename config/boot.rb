require 'rubygems'
# Set up gems listed in the Gemfile.
if File.exist?(File.expand_path('../../Gemfile', __FILE__))
  require 'bundler'
  Bundler.setup
end

require 'rails/all'
require 'mysql'

require 'authlogic'
require 'cancan'
require 'configatron'
# require 'searchlogic'
require 'rainbow'
require 'gravtastic'
require 'sanitize'
require 'will_paginate'
require 'octopi'


