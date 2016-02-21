module WagonTrain
  SchemaMismatch = Class.new(StandardError)

  module Sequel
    class Verifier
      MigrationRunnerNotSpecified = Class.new(StandardError)

      def initialize(schema, migration_runner = nil)
        @schema = schema
        @migration_runner = migration_runner
      end

      def verify(connection)
        sequel_schema = Schema.load(connection)
        if diff = schema - sequel_schema
          if ENV['RACK_ENV'] == "development"
            msg = "Your database schema and your schema file do not match. Use `verify!` to auto-migrate your database in development mode."
          else
            msg = "Your database schema and your schema file do not match."
          end

          raise SchemaMismatch, msg
        end
      end

      def verify!(connection)
        sequel_schema = Schema.load(connection)
        if diff = schema - sequel_schema
          if ENV['RACK_ENV'] == "development"
            raise MigrationRunnerNotSpecified, "An instance of WagonTrain::Migration::Runner was not passed to WagonTrain::Sequel::Verifier" if migration_runner.nil?
            migration_runner.run(WagonTrain::Migration.new(diff))
          else
            raise SchemaMismatch, "Your database schema and your schema file do not match."
          end
        else
          true
        end
      end

      private

      attr_reader :schema, :migration_runner
    end
  end
end