require 'wagon_train/utils/differ'

module WagonTrain
  SchemaDifference = Struct.new(:value, :previous_value, :tables, :enum_types) { include Visitable }
  TableDifference = Struct.new(:value, :previous_value, :columns) { include Visitable }
  ColumnDifference = Struct.new(:value, :previous_value) { include Visitable }
  EnumTypeDifference = Struct.new(:value, :previous_value, :values) { include Visitable }

  class Schema
    class << self
      define_method(:diff, &WagonTrain.differ(SchemaDifference, tables: :name, enum_types: :name))
    end
  end

  class Table
    class << self
      define_method(:diff, &WagonTrain.differ(TableDifference, columns: :name))
    end
  end

  class EnumType
    class << self
      define_method(:diff, &WagonTrain.differ(EnumTypeDifference, :values))
    end
  end
end