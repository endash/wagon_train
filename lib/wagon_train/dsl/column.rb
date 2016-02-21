module WagonTrain
  module DSL
    class Column
      attr_reader :column

      def self.load(*args)
        new(*args).column
      end

      def initialize(name, type, options = {})
        @column = WagonTrain::Column.new(name, type, options)
      end
    end
  end
end