$:.push File.expand_path('../lib', __FILE__)
require "whatcd/version"

Gem::Specification.new do |s|
  s.name        = 'whatcd'
  s.version     = WhatCD::VERSION
  s.summary     = 'An API wrapper for What.cd\'s JSON API'
  s.description = 'An API wrapper for What.cd\'s JSON API'
  s.authors     = ['Paul Brickfeld']
  s.email       = ['paulbrickfeld@gmail.com']
  s.homepage    = 'http://britishtea.github.com/whatcd'
  s.files       = Dir.glob 'lib/*.rb'

  s.add_dependency 'httparty'
end