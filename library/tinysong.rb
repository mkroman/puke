# encoding: utf-8

require 'json'
require 'net/http'
require 'puke/piece'

module Tinysong
  Version = 0, 0, 1
  
module_function
  
  def search query
    Net::HTTP.get(URI "http://tinysong.com/s/#{URI.escape query}?format=json").tap do |response|
      return JSON.parse(response).map &Puke::Piece.method(:new)
    end
  end
  
end