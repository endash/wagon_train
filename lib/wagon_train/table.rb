module WagonTrain
  class Table
    include Visitable

    attr_reader :name, :columns

    def initialize(name, columns)
      @name = name
      @columns = columns
    end

    def column(name)
      @columns.find { |c| c.name == name }
    end

    def ==(other_table)
      name == other_table.name &&
      columns.sort_by { |c| c.name } == other_table.columns.sort_by { |c| c.name }
    end

    def column_names
      @columns.map(&:name)
    end

    def -(other_table)
      self.class.diff(other_table, self)
    end
  end
end