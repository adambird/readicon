require 'spec_helper'

describe ReadTracker do
  before(:each) do
    @user = random_string
    @item_id = random_string
    @item_store = mock(ItemStore)
    ItemStore.stub(:new) { @item_store }
  end
  describe ".item_created" do
    before(:each) do
      @created_at = random_time
    end
    
    subject { ReadTracker.item_created(@user, @item_id, @created_at) }
    
    it "inserts the item in the store" do
      @item_store.should_receive(:create_item).with(@user, @item_id, @created_at)
      subject
    end
  end
  
  describe ".item_updated" do
    before(:each) do
      @updated_at = random_time
    end
    
    subject { ReadTracker.item_updated(@user, @item_id, @updated_at) }
    
    it "inserts the item in the store" do
      @item_store.should_receive(:set_updated_at).with(@user, @item_id, @updated_at)
      subject
    end
  end
  
  describe ".user_read_item" do
    
    it "does something"
  end
  
  describe ".read_states" do
    before(:each) do
      
    end
  end
end
