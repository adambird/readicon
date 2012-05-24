# Data mapper for persisting user read state for a given item
#
module Readicon
  class ReadStateStore
    include MongoStore

    set_collection_name :readicon_read_states
    set_indexes [
        [['user', 'id'], :unique => true]
      ]

    # Private - upsert item state record for the read operation
    #
    # user      - String identifying the user who read the item
    # id        - String uniquely identifying the item
    # at        - Time the item was read
    #
    # Returns nothing
    def record_read(user, id, at)
      collection.update({ 'user' => user, 'id' => id }, { '$set' => { 'read_at' => at.utc }}, { :upsert => true})
    end

    # Private - upsert item state record for the updated operation
    #
    # user      - String identifying the user who updated the item
    # id        - String uniquely identifying the item
    # at        - Time the item was updated
    #
    # Returns nothing
    def set_updated_at(id, at)
      collection.update({ 'id' => id }, { '$set' => { 'updated_at' => at.utc }}, { :multi => true})
    end

    # Public : get user ItemState
    #
    # user      - String identifying the user
    # ids       - String identifying the item to get state for
    #
    # Returns an ItemState or nil
    def get_state(user, id)
      if item = collection.find_one('user' => user, 'id' => id)
        ItemState.new(item)
      end
    end

    def get_states(user, ids)
      collection.find( 'user' => user, 'id' => { '$in' => ids }).collect { |is| ItemState.new(is) }
    end
  end
end