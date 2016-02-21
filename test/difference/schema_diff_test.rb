require 'wagon_train'
require 'minitest/autorun'

class SchemaDifferTest < Minitest::Test
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

  def enum_type
    WagonTrain::EnumType.new(:flavor, ["Cherry", "Strawberry", "Gross"])
  end

  def schema_with_users_table
    WagonTrain::Schema.new([users_table])
  end

  def schema_with_users_and_posts_tables
    WagonTrain::Schema.new([users_table, posts_table])
  end

  def schema_with_users_and_posts_tables_and_an_enum_type
    WagonTrain::Schema.new([users_table, posts_table], [enum_type])
  end

  def test_it_has_tables_hash
    diff = WagonTrain::Schema.diff(schema_with_users_table, schema_with_users_and_posts_tables)
    assert_equal diff.tables.added, [posts_table]
  end

  def test_it_has_enum_types_hash
    diff = WagonTrain::Schema.diff(schema_with_users_table, schema_with_users_and_posts_tables_and_an_enum_type)
    assert_equal diff.enum_types.added, [enum_type]
  end
end
