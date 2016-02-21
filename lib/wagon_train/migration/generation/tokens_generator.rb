module WagonTrain
  module Migration
    module Generation
      class TokensGenerator
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
          string << "create_table(:#{add_table.name})"
        end

        def visit_remove_table(remove_table)
          string << "drop_table(:#{remove_table.name})"
        end

        def visit_add_column(add_column)
          string << "table(:#{add_column.table}).add_column(:#{add_column.name})"
        end

        def visit_remove_column(remove_column)
          string << "table(:#{remove_column.table}).remove_column(:#{remove_column.name})"
        end

        # def visit_execute_query(execute_query)
        #   string << "execute '#{execute_query.query}'"
        # end
      end
    end
  end
end