require 'spec_helper'

describe Tartarus::Base do

  ActiveRecord::Base.connection.execute("DROP TABLE IF EXISTS 'foos'")
  ActiveRecord::Base.connection.create_table(:foos) do |t|
    t.string :foo
    t.string :bar
    t.string :widget
  end

  class Foo < ActiveRecord::Base
    tartarus :foo, :bar, :widget
  end

  before(:each) do
    ActiveRecord::Base.connection.increment_open_transactions
    ActiveRecord::Base.connection.begin_db_transaction
  end

  after(:each) do
    ActiveRecord::Base.connection.rollback_db_transaction
    ActiveRecord::Base.connection.decrement_open_transactions
  end

  [:foo, :bar].each do |attribute|
    it "is invalid when overwriting :#{attribute} with a null value" do
      thing = Foo.create(attribute => "baz")
      thing.send("#{attribute}=".to_sym, nil)
      thing.should_not be_valid
    end

    it "is valid when :#{attribute} is nil at creation time" do
      thing = Foo.new(attribute => "baz")
      thing.should be_valid
    end
  end

  it "is valid when changing :widget to null" do
    thing = Foo.create(:widget => "baz")
    thing.bar = nil
    thing.should be_valid
  end

  it "gives a helpful message" do
    thing = Foo.create(:foo => "baz")
    thing.foo = nil

    lambda {
      thing.save!
    }.should raise_error(ActiveRecord::RecordInvalid, "Validation failed: Foo can't be changed from 'baz' to nil")
  end

end