require 'spec_helper'

describe ItemState do
  describe "#new?" do
    subject { @state.new? }
    
    context "when no state recorded" do
      before(:each) do
        @state = ItemState.new
      end
      it "is false" do
        subject.should be_false
      end
    end    
    
    context "when has updated at but not read" do
      before(:each) do
        @state = ItemState.new(:updated_at => random_time)
      end
      it "is true" do
        subject.should be_true
      end
    end
    
    context "when has updated at but has read" do
      before(:each) do
        @state = ItemState.new(:read_at => random_time, :updated_at => random_time)
      end
      it "is false" do
        subject.should be_false
      end
    end
  end
  
  describe "#updated?" do
    subject { @state.updated? }
    
    context "when no state recorded" do
      before(:each) do
        @state = ItemState.new
      end
      it "is false" do
        subject.should be_false
      end
    end
    
    context "when read but not updated" do
      before(:each) do
        @state = ItemState.new(:read_at => random_time)
      end
      it "is false" do
        subject.should be_false
      end
    end
    
    context "when read but updated later" do
      before(:each) do
        @updated = Time.now
        @read_at = @updated - 60
        @state = ItemState.new(:read_at => @read_at, :updated_at => @updated)
      end
      it "is true" do
        subject.should be_true
      end
    end
    
    context "when read_at equals updated" do
      before(:each) do
        @updated = Time.now
        @read_at = @updated
        @state = ItemState.new(:read_at => @read_at, :updated_at => @updated)
      end
      it "is false" do
        subject.should be_false
      end
    end
    
    context "when read_at later than updated" do
      before(:each) do
        @updated = Time.now
        @read_at = @updated + 60
        @state = ItemState.new(:read_at => @read_at, :updated_at => @updated)
      end
      it "is false" do
        subject.should be_false
      end
    end
  end
end
