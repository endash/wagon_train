require 'wagon_train'
require 'minitest/autorun'

class SequenSchemaLoaderTest < Minitest::Test
  class FakeDatabase
    def initialize(tables=[], enum_types={})
      @tables = tables
      @enum_types = enum_types
    end

    def schema(table_name)
      @tables[table_name]
    end

    def tables
      @tables.keys
    end

    def enum_types
      @enum_types
    end
  end

  def simple_schema
    WagonTrain::DSL::Schema.load do |db|
      db.table(:users) do |t|
        t.uuid :id, null: false, default: "", primary_key: true
        t.string :name, null: false, default: "", primary_key: false
      end
    end
  end

  def simple_fake_database
    FakeDatabase.new({
      users: [[:id, {allow_null: false, db_type: "uuid", default: "", primary_key: true, type: :uuid}], [:name, {allow_null: false, db_type: "varchar(100)", default: "", primary_key: false, type: :string}]]
    })
  end

  def test_basic_case
    schema = WagonTrain::Sequel::Schema.load(simple_fake_database)
    expected_schema = simple_schema

    assert_equal expected_schema, schema
  end
end