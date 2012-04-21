# Portable representation of an item being tracked

module Readicon
  class Item
    
    attr_accessor :id, :updated_at
    
    def initialize(attrs={})
      attrs.each_pair do |k,v| send("#{k}=", v) if respond_to?("#{k}=") end
    end
  end
end