module WagonTrain
  module Sequel
    class Table
      attr_reader :table

      def self.load(name, table)
        new(name, table).table
      end

      def initialize(name, table)
        @table = WagonTrain::Table.new(name, table.map { |c| Column.load(c) })
      end
    end
  end
end
