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
  
  describe ".item_read" do
    before(:each) do
      @read_at = random_time
    end
    
    subject { @coordinator.item_read(@user, @item_id, @read_at) }
    
    it "marks the item as read in the read state store" do
      @read_state_store.should_receive(:record_item_read).with(@user, @item_id, @read_at)
      subject
    end
  end
  
  describe ".get_states" do
    before(:each) do
      @ids = [random_string, random_string, random_string]
      @read_state_store.stub(:get_states) { @read_states || [] }
      @item_store.stub(:get_items) { @items || [] } 
    end
    
    subject { @coordinator.get_states(@user, @ids) }
    
    it "gets the read states" do
      @read_state_store.should_receive(:get_states).with(@user, @ids)
      subject
    end
    
    context "when all have been read previously" do
      before(:each) do
        @read_states = @ids.collect { |id| ItemState.new(:id => id) }  
      end
      
      it "does not get unread items" do
        @item_store.should_not_receive(:get_items)
        subject
      end
    end
    
    context "when first one hasn't been read previously" do
      before(:each) do
        @read_states = [
            ItemState.new(:id => @ids[1]),
            ItemState.new(:id => @ids[2])
          ]
      end
      
      it "attempts to retrieve the item" do
        @item_store.should_receive(:get_items).with([@ids[0]])
        subject
      end
    end

  end
end
