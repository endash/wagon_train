module WagonTrain
  class Table
    include Visitable
    include Dry::Equalizer(:name, :columns, :constraints)

    attr_reader :name, :columns, :constraints

    def initialize(name, columns=[], constraints=[])
      @name = name
      @columns = Set.new(columns)
      @constraints = Set.new(constraints)
    end

    def column(name)
      @columns.find { |c| c.name == name }
    end

    def column_names
      @columns.map(&:name)
    end

    def -(other_table)
      self.class.diff(other_table, self)
    end
  end
end