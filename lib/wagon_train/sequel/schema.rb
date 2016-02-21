require 'wagon_train/sequel/column'
require 'wagon_train/sequel/table'

module WagonTrain
  module Sequel
    class Schema
      attr_reader :schema

      def self.load(database)
        new(database).schema
      end

      def initialize(database)
        @database = database
      end

      def schema
        WagonTrain::Schema.new(tables, enum_types)
      end

      private

      def enum_types
        database.enum_types.to_a.map { |enum| WagonTrain::EnumType.new(*enum) }
      end

      def tables
        database.tables.map { |table| Table.load(table, database.schema(table)) }
      end

      attr_reader :database
    end
  end
end
