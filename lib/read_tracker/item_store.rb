# Data mapper for persisting items being tracked

module ReadTracker
  class ItemStore
    include MongoStore
    
    def collection 
      @_collection ||= open_connection['items']   
    end
    
    def ensure_indexes
      collection.ensure_index([['id', Mongo::ASCENDING]], :unique => true)
    end
    
    def drop_collection
      collection.drop
      @_collection = nil
    end
    
    def create_item(id, at)
      collection.insert( { 'id' => id, 'created_at' => at.utc } )
    end
    
    def get_item(id)
      if item = collection.find_one('id' => id)
        Item.new(item)
      end
    end
  end
end