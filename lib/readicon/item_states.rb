# Representation of item states for a given user

module Readicon
  class ItemStates
    include Enumerable
    
    def each
      items.each_value
    end
    
    def [](id)
      items[id]
    end
    
    def []=(id, value)
      items[id] = value
    end
    
    def load(states)
      states.each do |state| items[state.id] = state end
    end
    
    def missing_items(ids)
      ids.select { |id| items[id].nil? }
    end
    
  private
    def items
      @_items ||= {}
    end
  end
end