require 'set'

module WagonTrain
  module DSL
    class Schema
      def initialize(&block)
        @tables = Set.new
        @enum_types = Set.new
        block.call(self) if block
      end

      def schema
        WagonTrain::Schema.new(@tables)
      end

      def table(name, &block)
        @tables << Table.load(name, &block)
      end

      def enum_type(name, values)
        @enum_types << EnumType.new(name, values)
      end

      def extension(*args)
      end

      def function(*args)
      end

      def lit(*args)
        WagonTrain.lit(*args)
      end
    end
  end
end