module WagonTrain
  module Migration
    class Migration
      attr_reader :operations

      def initialize schema_difference
        @operations = OperationCollector.new(schema_difference).operations
      end
    end
  end
end