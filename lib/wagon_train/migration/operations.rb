module WagonTrain
  module Migration
    class Operation
      include Visitable
    end

    class AddTable < Operation
      attr_reader :definition

      def initialize(definition)
        @definition = definition
      end

      def name
        @definition.name
      end

      def columns
        @definition.columns
      end

      def ==(other_op)
        definition == other_op.definition
      end
    end

    class RemoveTable < Operation
      attr_reader :name

      def initialize(name)
        @name = name
      end

      def ==(other_op)
        name == other_op.name
      end
    end

    class AddColumn < Operation
      attr_reader :table, :definition

      def initialize(table, definition)
        @table = table
        @definition = definition
      end

      def name
        @definition.name
      end

      def type
        @definition.type
      end

      def ==(other_op)
        table == other_op.table &&
        definition == other_op.definition
      end
    end

    class RemoveColumn < Operation
      attr_reader :table, :name
      def initialize(table, name)
        @table = table
        @name = name
      end

      def ==(other_op)
        table == other_op.table &&
        name == other_op.name
      end
    end

    class AlterColumn < Operation
    end

    class ExecuteQuery < Operation
      attr_reader :query
      def initialize(query)
        @query = query
      end
    end
  end
end
