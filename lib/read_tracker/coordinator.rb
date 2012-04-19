module ReadTracker
  class Coordinator
    def item_created(user, id, at)
      item_store.create_item(id, at)
      read_state_store.record_item_read(user, id, at)
    end
    
    def item_updated(user, id, at)
      item_store.set_updated_at(id, at)
      read_state_store.record_item_read(user, id, at)
      read_state_store.set_updated_at(id, at)
    end
    
    def item_store
      @_item_store ||= ItemStore.new
    end
    
    def read_state_store
      @_read_state_store ||= ReadStateStore.new
    end
  end
end