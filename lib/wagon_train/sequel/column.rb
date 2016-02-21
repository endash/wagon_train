module WagonTrain
  module Sequel
    class Column
      attr_reader :column

      def self.load(column)
        new(column).column
      end

      def initialize(column)
        name, props = column
        type = props[:type]

        options = {
          null: props[:allow_null],
          default: props[:default],
          primary_key: props[:primary_key],
          unique: props[:unique]
        }

        @column = WagonTrain::Column.new(name, type, options)
      end
    end
  end
end
