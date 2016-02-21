module WagonTrain
  module Migration
    class Runner
      include Visitor

      def initialize(connection)
        @connection = connection
      end

      def run(migration)
        connection.transaction do
          migration.operations.each { |op| op.accept(self) }
        end
      end

      private

      attr_reader :connection

      def visit_add_table(create_table)
        connection.create_table(create_table.name) do
          create_table.columns.each do |c|
            column c.name, c.type, c.options
          end
        end
      end
    end
  end
end