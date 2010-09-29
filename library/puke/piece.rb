# encoding: utf-8

module Puke
  class Piece
    class InvalidStream < StandardError; end
    
    def self.attribute name, value
      define_method name do; @attributes[value] end
    end
    
    attribute :id,     'SongID'
    attribute :url,    'Url'
    attribute :name,   'SongName'
    attribute :album,  'AlbumName'
    attribute :artist, 'ArtistName'
    
    def initialize attributes
      @attributes = attributes
    end
    
    def token; url[/\w+$/] end
    def title; "#{artist} – #{name}" end
    
    def stream
      @stream ||= Stream.new stream_info
    end
    
  private
  
    def stream_info
      puts stream_data
      Net::HTTP.start 'cowbell.grooveshark.com' do |http|
        post = Net::HTTP::Post.new '/more.php?getStreamKeyFromSongIDEx', { "Content-Type" => "application/json" }
        http.request post, stream_data do |response|
          #stream = JSON.parse response.body
          #return { host: stream['ip'], key: stream['streamKey'] }
          p response.body
        end
      end
    end
    
    def stream_data
      {
        header: {
          client: 'gslite',
          clientRevision: '20100831.17',
          country: {"CC1"=>"0","CC3"=>"0","ID"=>"223","CC2"=>"0","CC4"=>"1073741824"}
        },
        method: "getStreamKeyFromSongIDEx",
        parameters: {
          prefetch: false,
          country: {"CC1"=>"0","CC3"=>"0","ID"=>"223","CC2"=>"0","CC4"=>"1073741824"},
          mobile: false,
          songID: id
        }
      }.to_json
    end
  end
end