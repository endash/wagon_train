require 'wagon_train'
require 'minitest/autorun'

class DSLSchemaTest < Minitest::Test
  def test_parses_a_table
    schema = WagonTrain::DSL::Schema.load do |s|
      s.table(:table1) do |t|
        t.uuid :id
      end
    end

    assert schema.table(:table1)
  end
end