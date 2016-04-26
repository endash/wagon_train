module WagonTrain
  class Database
    attr_reader :connection

    def initialize(*args)
      @connection = Sequel.connect(*args)
    end

    def tables
      connection.tables
    end

    def enum_types
      values = connection.metadata_dataset.
        from(:pg_enum).
        order(:enumtypid, :enumsortorder).
        select_hash_groups(Sequel.cast(:enumtypid, Integer).as(:v), :enumlabel)

      types = connection.metadata_dataset.
        from(:pg_type).
        where(oid: labels.keys).
        exclude(typarray: 0).
        select_map([:oid, :typname])

      types.each_with_object do |type, h|
        h[t[1]] = values[t[0]]
      end
    end
  end
end
