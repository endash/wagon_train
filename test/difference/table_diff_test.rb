require 'wagon_train'
require 'minitest/autorun'

class TableDifferTest < Minitest::Test
  def users_table_with_one_column
    WagonTrain::Table.new(:users, [WagonTrain::Column.new(:id, :uuid, {primary_key: true, null: false})])
  end

  def users_table_with_two_columns
    WagonTrain::Table.new(:users, [WagonTrain::Column.new(:id, :uuid, {primary_key: true, null: false}), WagonTrain::Column.new(:name, :string, {primary_key: false, null: false})])
  end

  def test_it_has_column_hash
    diff = WagonTrain::Table.diff(users_table_with_one_column, users_table_with_two_columns)
    assert_equal diff.columns.added, [WagonTrain::Column.new(:name, :string, {primary_key: false, null: false})]
  end
end
