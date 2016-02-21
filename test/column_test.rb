require 'wagon_train'
require 'minitest/autorun'

class ColumnTest < Minitest::Test
  def test_same_name_type_and_options_are_equal
    column1 = WagonTrain::Column.new(:id, :uuid, {primary_key: true, null: false})
    column2 = WagonTrain::Column.new(:id, :uuid, {primary_key: true, null: false})

    assert_equal column1, column2
  end

  def test_same_name_different_type_are_not_equal
    column1 = WagonTrain::Column.new(:id, :uuid, {primary_key: true, null: false})
    column2 = WagonTrain::Column.new(:id, :string, {primary_key: true, null: true})

    assert column1 != column2
  end

  def test_same_name_and_type_but_different_option_are_not_equal
    column1 = WagonTrain::Column.new(:id, :uuid, {primary_key: true, null: false})
    column2 = WagonTrain::Column.new(:id, :uuid, {primary_key: true, null: true})

    assert column1 != column2
  end
end
