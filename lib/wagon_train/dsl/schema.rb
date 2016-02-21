module WagonTrain
  module DSL
    class Schema
      def self.load(&block)
        new(&block).schema
      end

      def initialize(&block)
        @tables = []
        @enum_types = []
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
    end
  end
end