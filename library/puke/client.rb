# encoding: utf-8

module Puke
  class Client
    def initialize
      @http = Net::HTTP.new 'tinysong.com'
    end
    
    def first query; search(query).first end
    
    def search query
      Array.new.tap do |pieces|
        request = Net::HTTP::Get.new "/s/#{URI.escape query}?format=json"
        @http.request request do |response|
          pieces.concat JSON.parse(response.body).map &Piece.method(:new)
          pieces.each { |piece| yield piece } if block_given?
        end
      end
    end
    
  end
end