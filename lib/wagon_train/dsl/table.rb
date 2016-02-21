module WagonTrain
  module DSL
    class Table
      def self.load(name, &block)
        new(name, &block).table
      end

      def initialize(name, &block)
        @name = name
        @columns = []
        block.call(self) if block
      end

      def table
        WagonTrain::Table.new(@name, @columns)
      end

      def column(*args, &block)
        @columns << Column.load(*args, &block)
      end

      def method_missing(*args, &block)
        column(args[1], args[0], *(args.drop(2)), &block)
      end
    end
  end
end