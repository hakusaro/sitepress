$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'mascot'
require 'mascot-rails'
require 'mascot-server'

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
