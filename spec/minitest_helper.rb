require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'pry'
require 'minitest/autorun'
require 'minitest/unit'
require 'minitest/pride'

require File.expand_path('../../lib/reindeer-etl.rb', __FILE__)
$dir = File.dirname(File.expand_path(__FILE__))

