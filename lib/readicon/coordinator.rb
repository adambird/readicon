# Private : Coordination layer between the Readicon facade methods and the storage layer
#
module Readicon
  class Coordinator
    # Private : record that an item was created
    #
    # user      - String identifying the user who created the item
    # id        - String uniquely identifying the item
    # at        - Time the item was created
    #
    # Returns nothing
    def item_created(user, id, at)
      item_store.create_item(id, at)
      read_state_store.record_read(user, id, at)
    end

    # Private : record that an item was updatd
    #
    # user      - String identifying the user who updated the item
    # id        - String uniquely identifying the item
    # at        - Time the item was updated
    #
    # Returns nothing
    def item_updated(user, id, at)
      item_store.set_updated_at(id, at)
      read_state_store.record_read(user, id, at)
      read_state_store.set_updated_at(id, at)
    end

    # Private : record that an item was read
    #
    # user      - String identifying the user who read the item
    # id        - String uniquely identifying the item
    # at        - Time the item was read
    #
    # Returns nothing
    def item_read(user, id, at)
      read_state_store.record_read(user, id, at)
    end

    # Public : get user ItemState for a series of items
    #
    # user      - String identifying the user
    # ids       - Array of Strings identifying the items to get state for
    #
    # Returns Enumerable of ItemState
    def get_states(user, ids)
      states = ItemStates.new

      states.load(read_state_store.get_states(user, ids))
      missing_ids = states.missing_items(ids)

      if missing_ids.count > 0
        states.load(item_store.get_items(missing_ids).collect { |item| ItemState.new(:id => item.id, :updated_at => item.updated_at)})
      end

      states
    end

    # Public : get user ItemState from the read state store
    #
    # user      - String identifying the user
    # ids       - String identifying the item to get state for
    #
    # Returns an ItemState or nil if user hasn't read item
    def get_state(user, id)
      read_state_store.get_state(user, id)
    end

    def item_store
      @_item_store ||= ItemStore.new
    end

    def read_state_store
      @_read_state_store ||= ReadStateStore.new
    end
  end
end