require 'set'

module WagonTrain
  class Schema
    include Visitable
    include Dry::Equalizer(:tables, :enum_types)

    def self.load(&block)
      DSL::Schema.new(&block).schema
    end

    attr_reader :tables, :enum_types

    def initialize(tables=[], enum_types=[])
      @tables = Set.new(tables)
      @enum_types = Set.new(enum_types)
    end

    def table(name)
      @tables.find { |t| t.name == name }
    end

    def enum_type(name)
      @enum_types.find { |e| e.name == name }
    end

    def table_names
      @tables.map(&:name)
    end

    def enum_type_names
      @enum_types.map(&:name)
    end

    def -(other_schema)
      self.class.diff(other_schema, self)
    end
  end
end