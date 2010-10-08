# encoding: utf-8

require 'tinysong'
require 'net/http'
require 'json'

module Puke
  Version = 0, 0, 1
  
module_function

  def search query
    Tinysong.search(query).tap do |result|
      result.each { |song| yield song } if block_given?
    end
  end
  
  def client; @client ||= Client.new end
end