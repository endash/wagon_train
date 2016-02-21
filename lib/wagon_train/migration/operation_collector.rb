module WagonTrain
  module Migration
    class OperationCollector
      include Visitor
      include Visitable

      attr_reader :operations

      def initialize(root)
        @operations = []
        @add_columns = []
        @remove_columns = []

        root.accept(self)
      end

      private

      def visit_table(table_definition)
        @operations << AddTable.new(table_definition)
      end

      def visit_schema_difference(schema_difference)
        (schema_difference.tables.added + schema_difference.tables.changed).each { |table| table.accept(self) }

        @operations += @add_columns
        @operations += @remove_columns

        @operations += schema_difference.tables.removed.map { |table| RemoveTable.new(table) }
      end

      def visit_table_difference(table_difference)
        @add_columns += table_difference.columns.added.map { |column| AddColumn.new(table_difference.value.name, column) }
        @remove_columns += table_difference.columns.removed.map { |column| RemoveColumn.new(table_difference.value.name, column) }
      end
    end
  end
end
