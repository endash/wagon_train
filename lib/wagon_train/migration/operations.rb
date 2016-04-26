module WagonTrain
  module Migration
    class Operation
      include Visitable
    end

    class AddTable < Operation
      include Dry::Equalizer(:definition)

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

      def constraints
        @definition.constraints
      end
    end

    class RemoveTable < Operation
      include Dry::Equalizer(:name)

      attr_reader :name

      def initialize(name)
        @name = name
      end
    end

    class AddColumn < Operation
      include Dry::Equalizer(:table, :definition)

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
    end

    class RemoveColumn < Operation
      include Dry::Equalizer(:table, :name)

      attr_reader :table, :name
      def initialize(table, name)
        @table = table
        @name = name
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
