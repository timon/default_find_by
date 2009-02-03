require File.dirname(__FILE__) + '/spec_helper'
require 'lib/default_find_by'

describe "default_find_by" do
  before(:all) do
    build_model :people do
      string :name
      text :profile

      default_find_by :name
    end
  end
  before(:each) do
    @me = Person.create(:name => "Artem Ignatiev", :profile => "A Rails Hacker")
  end

  it "should find by given column when first arg is string" do
    Person.should_not_receive(:find_by_id)
    Person.find("Artem Ignatiev").should == @me
  end

  it "should find by id when first arg is integer" do
    Person.should_receive(:find_from_ids).with([@me.id], anything).and_return @me
    Person.find(@me.id).should == @me
  end

  it "should fall back when first arg is symbol" do
    Person.should_receive(:find_initial).and_return :first
    Person.should_receive(:find_every).and_return :all
    Person.find(:first).should == :first
    Person.find(:all).should == :all
  end

  it "should return default_find_by field on #to_param" do
    @me.to_param.should == @me.name
  end
end
