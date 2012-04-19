module ReadTracker
  require "read_tracker/mongo_store"
  require "read_tracker/item"
  require "read_tracker/item_store"
  
  class << self
    def setup
      yield self
    end
    
    def connection_profile
      @_connection_profile ||= "mongodb://localhost/read_tracker_default"
    end

    def connection_profile=(value)
      @_connection_profile = value
    end
    
    def item_created(user, id, at)
      ItemStore.new.create_item(user, id, at)
    end
    
    def item_updated(user, id, at)
      ItemStore.new.set_updated_at(user, id, at)
    end
    
    def user_read_item(user, id, at)
      
    end
    
    def read_states(user, ids)
      
    end
  end
end