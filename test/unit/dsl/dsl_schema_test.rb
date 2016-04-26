require 'wagon_train'
require 'minitest/autorun'

class DSLSchemaTest < Minitest::Test
  def test_parses_a_table
    schema = WagonTrain::DSL::Schema.new do |s|
      s.table(:table1) do |t|
        t.uuid :id
      end
    end.schema

    assert schema.table(:table1)
  end
end