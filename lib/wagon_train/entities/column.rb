module WagonTrain
  class Column
    include Dry::Equalizer(:name, :type, :default, :null, :primary_key, :unique)

    attr_reader :name, :type, :default, :null, :primary_key, :unique

    def options
      {
        default: default,
        null: null,
        primary_key: primary_key,
        unique: unique
      }
    end

    def initialize(name, type, options = {})
      @name = name
      @type = type
      @default = options[:default]
      @null = options[:null]
      @primary_key = options[:primary_key]
      @unique = options[:unique]
    end

    def -(other_column)
      nil
    end
  end
end