# Base module for interacting with the mongo store used for persistence

require 'mongo'
require 'uri'

module ReadTracker
  module MongoStore
    include Mongo
    
    def self.included(klass)
      klass.class_eval do
        extend ClassMethods
      end
    end

    def open_connection
      @db ||= open_store
    end

    def open_store
      uri  = URI.parse(ReadTracker.connection_profile)
      Connection.from_uri(ReadTracker.connection_profile).db(uri.path.gsub(/^\//, ''))
    end
    
    def collection 
      @_collection ||= open_connection[self.class.collection_name]   
    end
    
    def drop_collection
      collection.drop
      @_collection = nil
    end

    def ensure_indexes
      self.class.indexes.each do |index| collection.ensure_index(index) end
    end

    module ClassMethods
      def set_collection_name(name)
        @_collection_name = name
      end
      def collection_name
        @_collection_name
      end
      def set_indexes(indexes)
        @_indexes = indexes
      end
      def indexes
        @_indexes || []
      end
    end
  end
end