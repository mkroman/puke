# encoding: utf-8

module Puke
  class Piece
    def self.attribute name, value;
      define_method name do
        @attributes["#{value}"]
      end
    end
    
    attribute :id, :SongID
    attribute :title,  :SongName
    attribute :artist, :ArtistName
    attribute :album,  :AlbumName
    
    def initialize attributes
      @attributes = attributes
    end
    
    def token; @attributes["Url"][/\w+$/] end
    
    def url
      name = self.title.gsub(/[^\s\w]/, '').gsub ' ', '+'
      %{http://listen.grooveshark.com/#/s/#{name}/#{token}}
    end
    
    def to_s
      %{#<#{self.class.name}:#{id} @name=#{name.inspect} @artist=#{artist.inspect} @album=#{album.inspect}>}
    end
  end
end