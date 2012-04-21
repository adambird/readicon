# Data mapper for persisting user read state for a given item

module Readicon
  class ReadStateStore
    include MongoStore
    
    set_collection_name :readicon_read_states
    set_indexes [
        [['user', 'id'], :unique => true]
      ]
      
    def record_read(user, id, at)
      collection.update({ 'user' => user, 'id' => id }, { '$set' => { 'read_at' => at.utc }}, { :upsert => true})
    end
    
    def set_updated_at(id, at)
      collection.update({ 'id' => id }, { '$set' => { 'updated_at' => at.utc }}, { :multi => true})
    end
    
    def get_states(user, ids)
      collection.find( 'user' => user, 'id' => { '$in' => ids }).collect { |is| ItemState.new(is) }
    end
  end
end