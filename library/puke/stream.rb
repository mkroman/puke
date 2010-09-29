# encoding: utf-8

module Puke
  class Stream
    attr_accessor :server
    
    def initialize server
      @server = server
    end
    
    def dump output
      each_chunk { |chunk| output.write chunk }
    end
    
  private
  
    def each_chunk
      Net::HTTP.start @server[:host] do |http|
        http.post2 '/stream.php', "streamKey=#{@server[:key]}" do |response|
          response.read_body { |chunk| yield chunk }
        end
      end
    end
    
  end
end