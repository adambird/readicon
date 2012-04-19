require 'spec_helper'

describe Coordinator do
  before(:each) do
    @user = random_string
    @item_id = random_string
    @coordinator = Coordinator.new
    @item_store = mock(ItemStore)
    @coordinator.stub(:item_store) { @item_store }
    @read_state_store = mock(ReadStateStore)
    @coordinator.stub(:read_state_store) { @read_state_store }
  end
  describe ".item_created" do
    before(:each) do
      @created_at = random_time
      @item_store.stub(:create_item)
      @read_state_store.stub(:record_item_read)
    end
    
    subject { @coordinator.item_created(@user, @item_id, @created_at) }
    
    it "inserts the item in the store" do
      @item_store.should_receive(:create_item).with(@item_id, @created_at)
      subject
    end
    it "records that creator has read the item" do
      @read_state_store.should_receive(:record_item_read).with(@user, @item_id, @created_at)
      subject
    end
  end
  
  describe ".item_updated" do
    before(:each) do
      @updated_at = random_time
      @item_store.stub(:set_updated_at)
      @read_state_store.stub(:record_item_read)
      @read_state_store.stub(:set_updated_at)
    end
    
    subject { @coordinator.item_updated(@user, @item_id, @updated_at) }
    
    it "inserts the item in the store" do
      @item_store.should_receive(:set_updated_at).with(@item_id, @updated_at)
      subject
    end
    it "records that updater has read the item" do
      @read_state_store.should_receive(:record_item_read).with(@user, @item_id, @updated_at)
      subject
    end
    it "update all read state items to reflect new updated_at" do
      @read_state_store.should_receive(:set_updated_at).with(@item_id, @updated_at)
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
