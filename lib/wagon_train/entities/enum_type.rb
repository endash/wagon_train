module WagonTrain
  class EnumType
    attr_reader :name, :values
    include Dry::Equalizer(:name, :values)

    def initialize(name, values)
      @name = name
      @values = values
    end

    def -(other)
      self.class.diff(other, self)
    end
  end
end
