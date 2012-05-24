require 'spec_helper'

describe Readicon do
  describe ".get_state" do
    before(:each) do
      @user = random_string
      @item_id = random_string
      @read_at = random_time

      Readicon.item_read(random_string, @item_id, random_time)
      Readicon.item_read(@user, @item_id, @read_at)
      Readicon.item_read(random_string, @item_id, random_time)
    end

    subject { Readicon.get_state(@user, @item_id) }

    it "returns the correct state" do
      subject.read_at.to_i.should eq(@read_at.to_i)
    end
  end
end
