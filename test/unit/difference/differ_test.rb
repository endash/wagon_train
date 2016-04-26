require 'wagon_train'
require 'minitest/autorun'

class DifferTest < Minitest::Test
  Person = Struct.new(:name, :age) do
    def -(other)
      age == other.age ? nil : self
    end
  end
  Group = Struct.new(:people)

  def differ
    WagonTrain.differ(Struct.new(:value, :previous_value, :people), [:people])
  end

  def keyed_differ
    WagonTrain.differ(Struct.new(:value, :previous_value, :people), [[:people, :name]])
  end

  def test_simple_identity_added_item
    group1 = Group.new([Person.new("Alice", 30)])
    group2 = Group.new([Person.new("Alice", 30), Person.new("Bob", 30)])
    diff = differ.call(group1, group2)

    assert_equal [Person.new("Bob", 30)], diff.people.added
  end

  def test_simple_identity_removed_item
    group1 = Group.new([Person.new("Alice", 30), Person.new("Bob", 30)])
    group2 = Group.new([Person.new("Alice", 30)])
    diff = differ.call(group1, group2)

    assert_equal [Person.new("Bob", 30)], diff.people.removed
  end

  def test_simple_identity_common_item
    group1 = Group.new([Person.new("Alice", 30), Person.new("Bob", 30)])
    group2 = Group.new([Person.new("Alice", 30)])
    diff = differ.call(group1, group2)

    assert_equal [Person.new("Alice", 30)], diff.people.common
  end

  def test_simple_identity_no_difference
    group1 = Group.new([Person.new("Alice", 30)])
    group2 = Group.new([Person.new("Alice", 30)])
    diff = differ.call(group1, group2)

    assert_equal nil, diff
  end

  def test_identity_proc_added_item
    group1 = Group.new([Person.new("Alice", 30)])
    group2 = Group.new([Person.new("Alice", 35), Person.new("Bob", 30)])
    diff = keyed_differ.call(group1, group2)

    assert_equal [Person.new("Bob", 30)], diff.people.added
  end

  def test_identity_proc_removed_item
    group1 = Group.new([Person.new("Alice", 35), Person.new("Bob", 30)])
    group2 = Group.new([Person.new("Alice", 30)])
    diff = keyed_differ.call(group1, group2)

    assert_equal ["Bob"], diff.people.removed
  end

  def test_identity_proc_changed_item
    group1 = Group.new([Person.new("Alice", 35), Person.new("Bob", 30)])
    group2 = Group.new([Person.new("Alice", 30), Person.new("Bob", 30)])
    diff = keyed_differ.call(group1, group2)

    assert_equal [Person.new("Alice", 30)], diff.people.changed
  end
end