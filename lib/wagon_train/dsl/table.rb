require 'set'

module WagonTrain
  module DSL
    class Table
      def self.load(name, &block)
        new(name, &block).table
      end

      def initialize(name, &block)
        @name = name
        @columns = Set.new
        @constraints = Set.new

        block.call(self) if block
      end

      attr_reader :name

      def table
        WagonTrain::Table.new(@name, @columns, @constraints)
      end

      def column(*args, &block)
        columns << Column.load(*args, &block)
      end

      def constraint(*args)
        @constraints << args
      end

      def method_missing(*args, &block)
        column(args[1], args[0], *(args.drop(2)), &block)
      end

      def lit(*args)
        WagonTrain.lit(*args)
      end

      private

      attr_reader :columns, :constraints
    end
  end
end