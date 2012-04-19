module ReadTracker
  class Coordinator
    def item_created(user, id, at)
      item_store.create_item(id, at)
      read_state_store.record_read(user, id, at)
    end
    
    def item_updated(user, id, at)
      item_store.set_updated_at(id, at)
      read_state_store.record_read(user, id, at)
      read_state_store.set_updated_at(id, at)
    end
    
    def item_read(user, id, at)
      read_state_store.record_read(user, id, at)
    end
    
    def get_states(user, ids)
      states = ItemStates.new
      
      states.load(read_state_store.get_states(user, ids))
      missing_ids = states.missing_items(ids)
      
      if missing_ids.count > 0
        states.load(item_store.get_items(missing_ids).collect { |item| ItemState.new(:id => item.id, :updated_at => item.updated_at)})
      end
      
      states
    end
    
    def item_store
      @_item_store ||= ItemStore.new
    end
    
    def read_state_store
      @_read_state_store ||= ReadStateStore.new
    end
  end
end