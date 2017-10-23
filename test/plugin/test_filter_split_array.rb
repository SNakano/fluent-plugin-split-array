require 'bundler/setup'
require 'test/unit'
require 'fluent/log'
require 'fluent/test'
require 'fluent/test/driver/filter'
require 'fluent/plugin/filter_split_array'

class RubyFilterTest < Test::Unit::TestCase
  include Fluent

  setup do
    Fluent::Test.setup
  end

  def emit(msg, conf='')
    d = Test::Driver::Filter.new(Plugin::SplitArrayFilter).configure(conf)
    d.run(default_tag: 'test') {
      d.feed(msg)
    }
    d.filtered
  end

  sub_test_case 'filter' do
    test 'execute to array' do
      msg = [{'a' => 'b'}, {'a' => 'c'}]
      es  = emit(msg)
      assert_equal(msg.count, es.count)
      es.each_with_index do |e, i|
        assert_equal(msg[i], e[0])
      end
    end
    test 'execute to hash' do
      msg = {'a' => 'b', 'c' => 'd'}
      es  = emit(msg)
      assert_equal(msg, es.first[1])
    end
    test 'execute to array with split_key' do
      msg = {'key1' => [{'a' => 'b'}, {'a' => 'c'}]}
      es  = emit(msg, conf='split_key key1')
      assert_equal(msg['key1'].count, es.count)
      es.each_with_index do |e, i|
        assert_equal(msg['key1'][i], e[1])
      end
    end
    test 'execute to hash with split_key' do
      msg = {'key1' => {'a' => 'b', 'c' => 'd'}}
      es  = emit(msg, conf='split_key key1')
      assert_equal(msg['key1'], es.first[1])
    end
  end
end
