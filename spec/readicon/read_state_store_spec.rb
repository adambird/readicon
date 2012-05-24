require 'spec_helper'

describe ReadStateStore do
  before(:each) do
    @store = ReadStateStore.new
    @store.drop_collection
  end

  describe "#record_read" do
    before(:each) do
      @user = random_string
      @item_id = random_string
      @read_at = random_time
    end

    subject { @store.record_read(@user, @item_id, @read_at) }

    it "returns a read state for that item" do
      subject
      @store.get_states(@user, [@item_id]).first.read_at.to_i.should eq(@read_at.to_i)
    end
  end

  describe "#set_updated_at" do
    before(:each) do
      @item_id = random_string
      @updated_at = random_time
      @store.record_read(random_string, @item_id, random_time)
      @store.record_read(random_string, @item_id, random_time)
    end

    subject { @store.set_updated_at(@item_id, @updated_at) }

    it "returns a read state for that item" do
      subject
      @store.get_states(@user, [@item_id]).each do |item_state|
        item_state.updated_at.to_i.should eq(@updated_at.to_i)
      end
    end
  end

  describe "#get_state" do
    before(:each) do
      @user = random_string
      @item_id = random_string
      @read_at = random_time

      @store.record_read(random_string, @item_id, random_time)
      @store.record_read(@user, @item_id, @read_at)
      @store.record_read(random_string, @item_id, random_time)
    end

    subject { @store.get_state(@user, @item_id) }

    it "returns the correct state" do
      subject.read_at.to_i.should eq(@read_at.to_i)
    end
  end
end
