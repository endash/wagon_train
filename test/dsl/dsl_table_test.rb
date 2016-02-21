require 'wagon_train'
require 'minitest/autorun'

class DSLTableTest < Minitest::Test
  def test_parses_a_column
    table = WagonTrain::DSL::Table.load(:table1) do |t|
      t.uuid :id
    end

    assert table.column(:id)
  end

  def test_parses_multiple_columns_with_options
    table = WagonTrain::DSL::Table.load(:table1) do |t|
      t.uuid :id, primary_key: true
      t.string :name, null: false
      t.integer :age, default: 1
    end

    assert_equal 3, table.columns.size
    assert_equal :uuid, table.column(:id).type
    assert_equal false, table.column(:name).null
  end
end