module WagonTrain
  class Schema
    include Visitable

    attr_reader :tables, :enum_types

    def initialize(tables=[], enum_types=[])
      @tables = tables
      @enum_types = enum_types
    end

    def table(name)
      @tables.find { |t| t.name == name }
    end

    def enum_type(name)
      @enum_types.find { |e| e.name == name }
    end

    def ==(other_schema)
      tables.sort_by { |t| t.name } == other_schema.tables.sort_by { |t| t.name } &&
      enum_types.sort_by { |e| e.name } == other_schema.enum_types.sort_by { |e| e.name }
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