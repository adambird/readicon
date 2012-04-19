# Portable representation of an item being tracked

module ReadTracker
  class Item
    
    attr_accessor :_id, :id, :created_at
    
    def initialize(attrs={})
      attrs.each_pair do |k,v| send("#{k}=", v) end
    end
  end
end