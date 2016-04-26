module WagonTrain
  module Migration
    module Generation
      def self.generate(migration)
        MigrationGenerator.new(migration).to_s
      end

      def self.generate_file(migration)
        FileGenerator.new(migration).to_s
      end

      class MigrationGenerator
        include Visitor

        def initialize(migration, name="", string_collector=StringCollector.new)
          @name = name
          @string = string_collector

          ([nil] + migration.operations).each_cons(2) do |last_operation, operation|
            string.newline unless last_operation.nil? || last_operation.is_a?(operation.class)
            operation.accept(self)
          end
        end

        def to_s
          string.to_s
        end

        private

        attr_reader :string

        def visit_add_table(add_table)
          block "create_table :#{add_table.name} do |t|" do
            add_table.definition.columns.each do |column|
              string << "t.#{column.type} :#{column.name}"
            end
            add_table.definition.constraints.each do |constraint|
              string << "t.constraint *Marshal.load(#{Marshal.dump(constraint)})"
            end
          end
        end

        def visit_remove_table(remove_table)
          string << "drop_table :#{remove_table.name}"
        end

        def visit_add_column(add_column)
          string << "add_column :#{add_column.table}, :#{add_column.name}, :#{add_column.type}"
        end

        def visit_remove_column(remove_column)
          string << "remove_column :#{remove_column.table}, :#{remove_column.name}"
        end

        def visit_execute_query(execute_query)
          string << "execute '#{execute_query.query}'"
        end
      end

      class FileGenerator < MigrationGenerator
        def to_s
          ["WagonTrain.migration do", string.map { |str| "  #{str}" }, "end"].flatten.join("\n")
        end
      end
    end
  end
end