#!/usr/bin/env ruby
# encoding: utf-8

$:.unshift File.dirname(__FILE__) + '/../library'
require 'puke'

Puke.search 'hitler' do |track|
  p track
end