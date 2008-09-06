require File.join(File.dirname(__FILE__) , "helpers")


describe "Waves::Cache" do
  def fill_cache
    cache = Waves::Cache.new
    cache[:key1] = "value1"
    cache[:key2] = "value2"
    cache
  end

  before do
    @cache = {}
    @cache = fill_cache
  end

  it "can find a value in the cache" do
    @cache = fill_cache
    @cache[:key1].should == "value1"
  end

  it "has members who obey their time-to-live" do
    @cache.store(:key3,"value3", 0.01)
    @cache[:key3].should == "value3"
    sleep 0.02
    @cache[:key3].should == nil
  end


  it "can delete a value from the cache" do
    @cache = fill_cache
    @cache.delete :key1
    @cache[:key1].should == nil
    @cache[:key2].should =="value2"
  end

  it "can delete multiple values from the cache" do
    @cache = fill_cache
    @cache.delete :key1, :key2
    @cache[:key1].should == nil
    @cache[:key2].should == nil
  end
  
  it "can clear the cache" do
    @cache = fill_cache
    @cache.clear
    @cache[:key1].should == nil
    @cache[:key2].should == nil
  end

end

require 'layers/cache/file_cache'
describe "Waves::Layers::Cache::FileCache" do

  def fill_cache
    cache = Waves::Layers::Cache::FileCache.new("/tmp")
    cache[:key1] = "value1"
    cache[:key2] = "value2"
    cache
  end

  it "can find a value in the cache" do
    @cache = fill_cache
    @cache[:key1].should == "value1"
    @cache.clear
  end

  it "can delete a value from the cache" do
    @cache = fill_cache
    @cache.delete :key1
    @cache[:key1].should == nil
    @cache[:key2].should == "value2"
    @cache.clear
  end

  it "can delete multiple values from the cache" do
    @cache = fill_cache
    @cache.delete :key1, :key2
    @cache[:key1].should == nil
    @cache[:key2].should == nil
    @cache.clear
  end

  it "has members who obey their time-to-live" do
    @cache.store(:key3,"value3",1)
    @cache[:key3].should == "value3"
    sleep 1.01
    #@cache[:key3].should == "value3"
    @cache[:key3].should == nil
  end
  
  it "can clear the cache" do
    @cache = fill_cache
    @cache.clear
    (@cache[:key1].nil? and @cache[:key2].nil?).should == true
    File.exist?('/tmp/' / 'key1').should == false
  end

end