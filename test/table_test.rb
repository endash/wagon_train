require 'wagon_train'
require 'minitest/autorun'

class TableTest < Minitest::Test
  def test_same_name_and_columns_are_equal
    table1 = WagonTrain::Table.new(:users, [WagonTrain::Column.new(:id, :uuid, {primary_key: true, null: false})])
    table2 = WagonTrain::Table.new(:users, [WagonTrain::Column.new(:id, :uuid, {primary_key: true, null: false})])

    assert_equal table1, table2
  end

  def test_same_name_and_columns_different_order_are_equal
    table1 = WagonTrain::Table.new(:users, [WagonTrain::Column.new(:name, :string, {primary_key: false, null: false}), WagonTrain::Column.new(:id, :uuid, {primary_key: true, null: false})])
    table2 = WagonTrain::Table.new(:users, [WagonTrain::Column.new(:id, :uuid, {primary_key: true, null: false}), WagonTrain::Column.new(:name, :string, {primary_key: false, null: false})])

    assert_equal table1, table2
  end

  def test_same_name_and_different_columns_are_not_equal
    table1 = WagonTrain::Table.new(:users, [WagonTrain::Column.new(:id, :uuid, {primary_key: true, null: false})])
    table2 = WagonTrain::Table.new(:users, [WagonTrain::Column.new(:id, :uuid, {primary_key: true, null: false}), WagonTrain::Column.new(:name, :string, {primary_key: false, null: false})])

    assert table1 != table2
  end

  def test_column_names
    table = WagonTrain::Table.new(:users, [WagonTrain::Column.new(:id, :uuid, {primary_key: true, null: false}), WagonTrain::Column.new(:name, :string, {primary_key: false, null: false})])
    assert_equal [:id, :name], table.column_names
  end
end