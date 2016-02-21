require 'wagon_train'
require 'minitest/autorun'

class DSLColumnTest < Minitest::Test
  def test_parses_a_simple_column
    column = WagonTrain::DSL::Column.load(:id, :uuid)

    assert_equal :uuid, column.type
    assert_equal :id, column.name
  end

  def test_parses_default_option
    column = WagonTrain::DSL::Column.load(:name, :string, default: "Alice")

    assert_equal "Alice", column.default
  end

  def test_parses_null_option
    column = WagonTrain::DSL::Column.load(:name, :string, null: false)

    assert_equal false, column.null
  end

  def test_parses_primary_key_option
    column = WagonTrain::DSL::Column.load(:name, :string, primary_key: true)

    assert_equal true, column.primary_key
  end

  def test_parses_unique_option
    column = WagonTrain::DSL::Column.load(:name, :string, unique: true)

    assert_equal true, column.unique
  end
end