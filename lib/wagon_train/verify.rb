module WagonTrain
  def self.verify(connection, schema)
    verifier(connection).verify
  end

  def self.verify!(connection, schema)
    verifier(connection).verify!
  end

  private

  def verifier(connection)
    WagonTrain::Sequel::Verifier.new(schema, WagonTrain::Migration::Runner.new(connection))
  end
end