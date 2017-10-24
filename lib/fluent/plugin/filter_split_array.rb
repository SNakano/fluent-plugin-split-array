require 'fluent/plugin/filter'

module Fluent::Plugin
  class SplitArrayFilter < Filter
    Fluent::Plugin.register_filter('split_array', self)

    desc "Key name to split"
    config_param :split_key, :string, default: nil

    def filter_stream(tag, es)
      new_es = Fluent::MultiEventStream.new
      es.each {|time, record|
        target_record = @split_key.nil? ? record : record[@split_key] || {}
        split(time, target_record, new_es)
      }
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
