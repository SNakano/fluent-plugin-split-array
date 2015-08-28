require 'test/unit'
require 'fluent/log'
require 'fluent/test'
require 'fluent/plugin/filter_split_array'

class RubyFilterTest < Test::Unit::TestCase
  include Fluent

  setup do
    Fluent::Test.setup
  end

  def emit(msg)
    d = Test::FilterTestDriver.new(SplitArrayFilter).configure('', true)
    d.run {
      d.emit(msg, Fluent::Engine.now)
    }.filtered
  end

  sub_test_case 'filter' do
    test 'execute to array' do
      msg = [{'a' => 'b'}, {'a' => 'c'}]
      es  = emit(msg)
      assert_equal(msg.count, es.count)
      es.each_with_index do |e, i|
        assert_equal(msg[i], e[1])
      end
    end
    test 'execute to hash' do
      msg = {'a' => 'b', 'c' => 'd'} 
      es  = emit(msg)
      assert_equal(msg, es.first[1])
    end
  end
end
