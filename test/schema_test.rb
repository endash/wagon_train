require 'wagon_train'
require 'minitest/autorun'

class SchemaTest < Minitest::Test
  def users_table
    columns = [
      WagonTrain::Column.new(:id, :uuid, {primary_key: true, null: false}),
      WagonTrain::Column.new(:name, :string, {primary_key: false, null: false})
    ]
    WagonTrain::Table.new(:users, columns)
  end

  def posts_table
    columns = [
      WagonTrain::Column.new(:id, :uuid, {primary_key: true, null: false}),
      WagonTrain::Column.new(:title, :string, {primary_key: false, null: false}),
      WagonTrain::Column.new(:body, :string, {primary_key: false, null: false})
    ]
    WagonTrain::Table.new(:posts, columns)
  end

  def test_equality_order_of_tables_is_irrelevant
    schema1 = WagonTrain::Schema.new([users_table, posts_table])
    schema2 = WagonTrain::Schema.new([posts_table, users_table])

    assert_equal schema1, schema2
  end

  def test_table_names
    schema = WagonTrain::Schema.new([users_table, posts_table])

    assert_equal [:users, :posts], schema.table_names
  end
end
