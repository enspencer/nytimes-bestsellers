# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require File.expand_path("../lib/nytimes-bestsellers/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'nytimes-bestsellers'
  s.version     = Bestsellers::VERSION
  s.date        = '2013-11-25'
  s.summary     = %Q{Gem for accessing the NYTimes Bestsellers API}
  s.description = %Q{Gem for accessing the NYTimes Bestsellers API}
  s.authors     = ["Emma"]
  s.email       = 'emma.n.spencer@gmail.com'
  s.files       = ["lib/nytimes-bestsellers.rb"]
  s.homepage    =
    'http://github.com/enspencer/nytimes-bestsellers'
  s.license       = 'MIT'
end