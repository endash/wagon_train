require 'wagon_train'
require 'minitest/autorun'

class GenerationMigrationOperationCollectorTest < Minitest::Test
  def base_schema
    WagonTrain::DSL::Schema.new do |s|
      s.table(:alice) do |t|
        t.string :column1
        t.string :column2
      end
    end
  end

  def base_schema_with_added_column
    WagonTrain::DSL::Schema.new do |s|
      s.table(:alice) do |t|
        t.string :column1
        t.string :column2
        t.string :column3
      end
    end
  end

  def base_schema_with_removed_column
    WagonTrain::DSL::Schema.new do |s|
      s.table(:alice) do |t|
        t.string :column1
      end
    end
  end

  def base_schema_with_renamed_column
    WagonTrain::DSL::Schema.new do |s|
      s.table(:alice) do |t|
        t.string :column1
        t.string :column3
      end
    end
  end

  def base_schema_with_bob_table
    WagonTrain::DSL::Schema.new do |s|
      s.table(:alice) do |t|
        t.string :column1
        t.string :column2
      end

      s.table(:bob) do |t|
        t.string :column1
      end
    end
  end

  def base_schema_with_charlie_table
    WagonTrain::DSL::Schema.new do |s|
      s.table(:alice) do |t|
        t.string :column1
        t.string :column2
      end

      s.table(:charlie) {}
    end
  end

  def test_it_finds_added_tables
    old_schema = base_schema.schema
    new_schema = base_schema_with_bob_table.schema

    collector = WagonTrain::Migration::OperationCollector.new(new_schema - old_schema)

    assert_equal [
      WagonTrain::Migration::AddTable.new(new_schema.table(:bob))
    ], collector.operations
  end

  def test_it_finds_removed_tables
    old_schema = base_schema_with_bob_table.schema
    new_schema = base_schema.schema

    collector = WagonTrain::Migration::OperationCollector.new(new_schema - old_schema)

    assert_equal [
      WagonTrain::Migration::RemoveTable.new(:bob)
    ], collector.operations
  end

  def test_it_finds_added_columns
    old_schema = base_schema.schema
    new_schema = base_schema_with_added_column.schema

    collector = WagonTrain::Migration::OperationCollector.new(new_schema - old_schema)

    assert_equal [
      WagonTrain::Migration::AddColumn.new(:alice, new_schema.table(:alice).column(:column3))
    ], collector.operations
  end

  def test_it_finds_removed_columns
    old_schema = base_schema.schema
    new_schema = base_schema_with_removed_column.schema

    collector = WagonTrain::Migration::OperationCollector.new(new_schema - old_schema)

    assert_equal [
      WagonTrain::Migration::RemoveColumn.new(:alice, :column2)
    ], collector.operations
  end
end
