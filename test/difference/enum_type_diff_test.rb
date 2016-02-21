require 'wagon_train'
require 'minitest/autorun'

class EnumTypeDifferTest < Minitest::Test
  def enum_type_with_one_value
    WagonTrain::EnumType.new(:flavor, ["Cherry"])
  end

  def enum_type_with_two_values
    WagonTrain::EnumType.new(:flavor, ["Cherry", "Strawberry"])
  end

  def test_it_has_values_hash
    diff = WagonTrain::EnumType.diff(enum_type_with_one_value, enum_type_with_two_values)
    assert diff.values
  end
end
