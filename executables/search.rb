#!/usr/bin/env ruby
# encoding: utf-8

$:.unshift File.dirname(__FILE__) + '/../library'
require 'puke'

Puke::Client.new.search 'ohoi' do |song|
  puts "#{song.title}: #{song.stream} …"
end