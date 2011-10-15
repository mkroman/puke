# encoding: utf-8

require 'cgi'
require 'json'
require 'open-uri'

require 'puke/piece'

module Puke
  Version = "0.0.2"

  def self.search query, key
    pieces = []

    open "http://tinysong.com/s/#{URI.escape query}?format=json&key=#{key}" do |response|
      songs  = JSON.parse response.read
      pieces = songs.map &Piece.method(:new)
    end

    pieces
  end
end