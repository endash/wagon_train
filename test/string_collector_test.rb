require 'wagon_train'
require 'minitest/autorun'

class GenerationStringCollectorTest < Minitest::Test
  def new_collector
    WagonTrain::StringCollector.new
  end

  def test_adding_a_string_with_push_operator
    collector = new_collector
    collector << "test"

    assert_equal "test", collector.to_s
  end

  def test_increase_indent_increases_the_indent_level_by_1
    collector = new_collector
    collector.increase_indent
    collector << "test"

    assert_equal "  test", collector.to_s
  end

  def test_increase_indent_2_increases_the_indent_level_by_2
    collector = new_collector
    collector.increase_indent(2)
    collector << "test"

    assert_equal "    test", collector.to_s
  end

  def test_decrease_indent_decreases_the_indent_level_by_1
    collector = new_collector
    collector.increase_indent(2)
    collector.decrease_indent
    collector << "test"

    assert_equal "  test", collector.to_s
  end

  def test_decrease_indent_2_decreases_the_indent_level_by_2
    collector = new_collector
    collector.increase_indent(3)
    collector.decrease_indent(2)
    collector << "test"

    assert_equal "  test", collector.to_s
  end

  def test_decrease_indent_doesnt_decrease_past_0
    collector = new_collector
    collector.decrease_indent(2)
    collector.increase_indent(1)
    collector << "test"

    assert_equal "  test", collector.to_s
  end

  def test_newline
    collector = new_collector
    collector.newline
    collector << "test"
    assert_equal "\ntest", collector.to_s
  end

  def test_block
    collector = new_collector
    collector.block("start") do
      collector << "test"
      collector << "test2"
    end

    assert_equal "start\n  test\n  test2\nend", collector.to_s
  end
end