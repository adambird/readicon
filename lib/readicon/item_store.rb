# Data mapper for persisting items being tracked
#
module Readicon
  class ItemStore
    include MongoStore

    set_collection_name :readicon_items
    set_indexes [
      [['id']], :unique => true
    ]

    def create_item(id, at)
      collection.insert( { 'id' => id, 'updated_at' => at.utc } )
    end

    def set_updated_at( id, at)
      collection.update( { 'id' => id}, { '$set' => {'updated_at' => at.utc } }, { :upsert => true } )
    end

    def get_item(id)
      if item = collection.find_one('id' => id)
        Item.new(item)
      end
    end

    def get_items(ids)
      collection.find('id' => { '$in' => ids}).collect { |item| Item.new(item)}
    end
  end
end