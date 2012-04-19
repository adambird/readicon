require 'mongo'
require 'uri'

module ReadTracker
  module MongoStore
    include Mongo
    
    def open_connection
      @db ||= open_store
    end

    def open_store
      uri  = URI.parse(ReadTracker.connection_profile)
      Connection.from_uri(ReadTracker.connection_profile).db(uri.path.gsub(/^\//, ''))
    end
  end
end