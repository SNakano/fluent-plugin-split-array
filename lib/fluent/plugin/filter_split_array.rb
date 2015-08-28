module Fluent
  class SplitArrayFilter < Filter
    Fluent::Plugin.register_filter('split_array', self)
    def filter_stream(tag, es)
      new_es = MultiEventStream.new
      es.each {|time, record| split(time, record, new_es) }
      new_es
    end

    private

    def split(time, record, new_es)
      if record.instance_of?(Array)
        record.each { |r| new_es.add(time, r) }
      else
        new_es.add(time, record)
      end
    end
  end
end
