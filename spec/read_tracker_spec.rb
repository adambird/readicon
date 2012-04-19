require 'spec_helper'

describe ReadTracker do
  describe ".item_created" do
    before(:each) do
      @item_id = random_string
      @created_at = random_time
      @item_store = mock(ItemStore, :create_item => true)
      ItemStore.stub(:new) { @item_store }
    end
    
    subject { ReadTracker.item_created(@item_id, @created_at) }
    
    it "inserts the item in the store" do
      @item_store.should_receive(:create_item).with(@item_id, @created_at)
      subject
    end
  end
  
  describe ".item_updated" do
    it "does something"
  end
  
  describe ".user_read_item" do
    it "does something"
  end
end
