require 'spec_helper'

describe ItemStore do
  before(:each) do
    @store = ItemStore.new
    @store.drop_collection
  end
  
  describe "#create_item" do
    before(:each) do
      @item_id = random_string
      @created_at = random_time
    end
    
    subject { @store.create_item(@item_id, @created_at) }
    
    it "adds the item to the store" do
      subject
      @store.get_item(@item_id).updated_at.to_i.should eq(@created_at.to_i)
    end
  end
  
  describe "#set_updated_at" do
    before(:each) do
      @item_id = random_string
      @updated_at = random_time
      @store.create_item(@item_id, random_time)
    end
    
    subject { @store.set_updated_at(@item_id, @updated_at) }
    
    it "adds the item to the store" do
      subject
      @store.get_item(@item_id).updated_at.to_i.should eq(@updated_at.to_i)
    end
  end
  
end
