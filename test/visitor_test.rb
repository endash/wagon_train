require 'wagon_train'
require 'minitest/autorun'

class VisitorTest < Minitest::Test
  class AVisitor
    include WagonTrain::Visitor

    def visit_visitable(visitable)
      true
    end
  end

  class Visitable
    include WagonTrain::Visitable
  end

  def test_visitor_calls_the_appropriate_method_for_the_class
    assert Visitable.new.accept(AVisitor.new)
  end
end