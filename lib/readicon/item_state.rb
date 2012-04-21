# Representation of item state for a given user

module Readicon
  class ItemState
    
    attr_accessor :user, :id, :read_at, :updated_at
    
    def initialize(attrs={})
      attrs.each_pair do |k,v| send("#{k}=", v) if respond_to?("#{k}=") end
    end
    
    def updated?
      read_at && updated_at && updated_at > read_at
    end
    
    def new?
      read_at.nil? && updated_at
    end
  end
end