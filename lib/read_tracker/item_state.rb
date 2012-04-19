# Representation of item state for a given user

module ReadTracker
  class ItemState
    
    attr_accessor :user, :id, :read_at, :updated_at
    
    def initialize(attrs={})
      attrs.each_pair do |k,v| send("#{k}=", v) if respond_to?("#{k}=") end
    end
  end
end