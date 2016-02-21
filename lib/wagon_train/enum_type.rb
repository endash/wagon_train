module WagonTrain
  class EnumType
    attr_reader :name, :values

    def initialize(name, values)
      @name = name
      @values = values
    end

    def ==(other)
      name == other.name &&
      values == other.values
    end

    def -(other)
      self.class.diff(other, self)
    end
  end
end
