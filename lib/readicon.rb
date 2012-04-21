module Readicon
  require "readicon/mongo_store"
  require "readicon/item"
  require "readicon/item_state"
  require "readicon/item_states"
  require "readicon/item_store"
  require "readicon/read_state_store"
  require "readicon/coordinator"
  
  class << self
    def setup
      yield self
    end
    
    def connection_profile
      @_connection_profile ||= "mongodb://localhost/readicon_default"
    end

    def connection_profile=(value)
      @_connection_profile = value
    end
    
    def item_created(user, id, at)
      coordinator.item_created(user, id, at)
    end
    
    def item_updated(user, id, at)
      coordinator.item_updated(user, id, at)
    end

    def item_read(user, id, at)
      coordinator.item_read(user, id, at)
    end
    
    def get_states(user, ids)
      coordinator.get_states(user, ids)
    end
    
    private 
      def coordinator
        @_coordinator ||= Coordinator.new
      end
    
  end
end